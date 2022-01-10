using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace apiplate.Domain.Services
{
    public interface IGeneralService{
        Task<object> GetCounters();
        IList<String> GetGallery();

    }
}