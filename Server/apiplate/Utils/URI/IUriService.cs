using System;
using apiplate.Resources.Wrappers.Filters;

namespace apiplate.Utils.URI
{
    public interface IUriService
    {
        Uri GetPageUri(PaginationFilter filter, string route);
        string GetBaseUri();
    }

}