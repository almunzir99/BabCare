using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using apiplate.DataBase;
using apiplate.Domain.Models;
using apiplate.Domain.Services;
using apiplate.Extensions;
using apiplate.Resources;
using apiplate.Resources.Wrappers.Filters;
using apiplate.Utils.URI;
using AutoMapper;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace apiplate.Services
{
    public class BaseRepository<TModel, TResource> : IRepository<TModel, TResource> where TModel : BaseModel where TResource : BaseResource
    {
        protected readonly ApiplateDbContext _context;
        protected readonly IMapper _mapper;
        protected readonly DbSet<TModel> _dbSet;
        protected IList<Expression<Func<TModel, object>>> propsToLoad;

        public BaseRepository(IMapper mapper, ApiplateDbContext context, IUriService uriSerivce)
        {

            _mapper = mapper;
            _context = context;
            _dbSet = _context.Set<TModel>();
        }

        public virtual async Task<TResource> CreateAsync(TResource item, int userId)
        {
            try
            {
                var mappedItem = _mapper.Map<TResource, TModel>(item);
                mappedItem.CreatedAt = DateTime.Now;
                mappedItem.LastUpdate = DateTime.Now;
                await _dbSet.AddAsync(mappedItem);
                await _context.SaveChangesAsync();
                var result = _mapper.Map<TModel, TResource>(mappedItem);
                return result;
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception e)
            {

                throw e;
            }


        }

        public virtual async Task DeleteAsync(int id)
        {
            try
            {
                var target = await GetDbSet().SingleOrDefaultAsync(c => c.Id == id);
                if (target == null)
                    throw new System.Exception("The target Item doesn't Exist");
                _dbSet.Remove(target);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception e)
            {

                throw e;
            }


        }
        public virtual async Task<IList<TResource>> ListAsync(PaginationFilter filter, IList<Func<TModel, bool>> conditions = default, string search = "", string orderBy = "LastUpdate", bool ascending = true)
        {
            if (search == null) search = "";
            var validFilter = (filter == null) ?
            new PaginationFilter()
            : new PaginationFilter(filter.PageIndex, filter.PageSize);
            var list = await GetDbSet().ToListAsync();
            if (conditions != default)
            {
                foreach (var condition in conditions)
                {
                    list = list.Where(condition).ToList();
                }
            }
            list = list
            .Where(c => (GetSearchPropValue(c) == null)
            ? true
            : GetSearchPropValue(c).ToLower().Contains(search.ToLower())).ToList();
            list = list
            .Skip((validFilter.PageIndex - 1) * validFilter.PageSize)
            .Take(validFilter.PageSize).ToList();
            var result = _mapper.Map<List<TModel>, List<TResource>>(list);
            result = OrderBy(result, orderBy, ascending);
            return result;

        }

        protected virtual string GetSearchPropValue(TModel obj)
        {
            var type = typeof(TModel);
            var searchProp = type.GetProperties().SingleOrDefault(c => c.Name.ToLower() == "title");
            var propValue = searchProp?.GetValue(obj).ToString();
            return propValue;
        }
        protected List<TResource> OrderBy(IList<TResource> list, string prop, Boolean ascending)
        {
            //Get ordering Prop
            var type = typeof(TResource);
            var orderedList = list.OrderBy(c => c.LastUpdate).ToList();
            var orderProp = type.GetProperties().SingleOrDefault(c => c.Name.ToLower() == prop.ToLower());
            if (orderProp == null)
                throw new Exception("ordering property isn't available");
            if (ascending)
                orderedList = list.OrderBy(c => orderProp.GetValue(c, null)).ToList();
            else
                orderedList = list.OrderByDescending(c => orderProp.GetValue(c, null)).ToList();
            return orderedList;

        }
        public virtual async Task<int> GetTotalRecords()
        {
            return await _dbSet.CountAsync();
        }
        public async Task<IList<TResource>> SearchAsync(Func<TModel, bool> predicate)
        {
            var result = await GetDbSet().ToListAsync();
            result = result.Where(predicate).ToList();
            var mappedResult = _mapper.Map<IList<TModel>, IList<TResource>>(result);
            return mappedResult;
        }

        public virtual async Task<TResource> SingleAsync(int id)
        {
            var result = await GetDbSet().SingleOrDefaultAsync(c => c.Id == id);
            if (result == null)
                throw new Exception("item is not found");
            var mappedResult = _mapper.Map<TModel, TResource>(result);
            return mappedResult;
        }

        public virtual async Task<TResource> UpdateAsync(int id, TResource newItem)
        {
            var result = await _dbSet.SingleOrDefaultAsync(c => c.Id == id);
            if (result == null)
                throw new Exception("item is not found");
            _mapper.Map<TResource, TModel>(newItem, result);
            result.LastUpdate = DateTime.Now;
            var save = await _context.SaveChangesAsync();
            if (save == -1)
                throw new Exception("saving changes to database failed");
            var mappedResult = _mapper.Map<TModel, TResource>(result);
            return mappedResult;
        }
        public virtual async Task<TResource> UpdateAsync(int id, JsonPatchDocument<TModel> newItem)
        {
            try
            {
                var result = await _dbSet.SingleOrDefaultAsync(c => c.Id == id);
                if (result == null)
                    throw new Exception("item is not found");
                newItem.ApplyTo(result);
                result.LastUpdate = DateTime.Now;
                var save = await _context.SaveChangesAsync();
                var mappedResult = _mapper.Map<TModel, TResource>(result);
                return mappedResult;
            }
            catch (DbUpdateException exception)
            {
                throw new System.Exception(exception.Decode());
            }
            catch (System.Exception e)
            {

                throw e;
            }
        }
        protected virtual IQueryable<TModel> GetDbSet()
        {
            return _dbSet;
        }
        public async Task CreateActivity(int user_Id, int rowId, string action)
        {
            var tableTitle = typeof(TModel).Name;
            Activity activity = new Activity(user_Id, tableTitle, rowId, action, DateTime.Now);
            var user = await _context.Users.SingleOrDefaultAsync(c => c.Id == user_Id);
            if (user == null)
                throw new Exception("target user isn't found");
            user.Activities.Add(activity);
            var save = await _context.SaveChangesAsync();
            if (save == -1)
                throw new Exception("saving changes to database failed");



        }
        public async Task<FileContentResult> ExportToCSV()
        {
            // list of properties
            Type type = typeof(TModel);
            var title = type.Name;
            var properties = type.GetProperties().Where(c => c.PropertyType.IsPrimitive ||
                     c.PropertyType == typeof(String)
                     || c.PropertyType == typeof(DateTime)).ToList();
            var propertiesNames = properties.Select(c => c.Name);
            var data = new StringBuilder();

            string header = "";
            //create header 
            int index = 0;
            foreach (var name in propertiesNames)
            {
                header += name;
                if (index < propertiesNames.Count() - 1)
                    header += ",";
                index++;
            }
            data.AppendLine(header);
            var list = await GetDbSet().ToListAsync();
            var filteredProps = properties.Where(c => c.PropertyType.IsPrimitive ||
                     c.PropertyType == typeof(String)
                     || c.PropertyType == typeof(DateTime)).ToList();
            foreach (var item in list)
            {
                string value = "";
                int i = 0;
                foreach (var prop in filteredProps)
                {

                    var propValue = prop.GetValue(item)?.ToString();
                    propValue = propValue?.Replace(",", "");
                    value += propValue;
                    if (i < filteredProps.Count() - 1)
                        value += ",";
                    i++;

                }
                data.AppendLine(value);
            }

            var result = new FileContentResult(Encoding.UTF8.GetBytes(data.ToString()),
            "text/csv")
            {
                FileDownloadName = $"{title}.csv",
            };
            return result;
        }


    }


}