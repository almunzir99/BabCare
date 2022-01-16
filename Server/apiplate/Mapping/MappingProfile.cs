using apiplate.Domain.Models;
using apiplate.Resources;
using AutoMapper;

namespace apiplate.Mapping
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            this.CreateMap<RoleResource, Role>();
            this.CreateMap<PermissionResource, Permission>();
            this.CreateMap<AdminResource, Admin>();
            this.CreateMap<MessageResource, Message>();
            this.CreateMap<AdminResource, Admin>();
            this.CreateMap<CustomerResource, Customer>();
            this.CreateMap<DeliveryDriverResource, DeliveryDriver>();
            this.CreateMap<NotificationResource, Notification>();
            this.CreateMap<ProductResource, Product>();
            this.CreateMap<CategoryResource, Category>();
            this.CreateMap<OptionResource, Option>();
            this.CreateMap<OptionValueResource, OptionValue>();
            this.CreateMap<AddOnResource, AddOn>();
            this.CreateMap<BranchResource, Branch>();
            this.CreateMap<ImageResource, Image>();






        }
        public void CreateMap<TResource, TModel>(string IgnoreItem = null)
         where TResource : BaseResource where TModel : BaseModel
        {
            base.CreateMap<TResource, TModel>()
            .ForMember(c => c.Id, opt => opt.Condition(c => c.Id
             != null))
            .ForMember(c => c.CreatedAt, opt => opt.Condition(c => c.CreatedAt != default))
            .ReverseMap();

        }
    }

}