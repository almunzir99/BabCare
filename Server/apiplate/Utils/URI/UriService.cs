using System;
using apiplate.Resources.Wrappers.Filters;
using Microsoft.AspNetCore.WebUtilities;

namespace apiplate.Utils.URI
{
    public class UriService : IUriService
    {
        private readonly string _baseUri;

        public UriService(string baseUri)
        {
            _baseUri = baseUri;
        }
        public string GetBaseUri()
        {
            return this._baseUri;
        }
        public Uri GetPageUri(PaginationFilter filter, string route)
        {
            var _endPoint = new Uri(String.Concat(_baseUri, route));
            var _endPointWithParams = QueryHelpers.AddQueryString(_endPoint.ToString(), "pageIndex", filter.PageIndex.ToString());
            _endPointWithParams = QueryHelpers.AddQueryString(_endPointWithParams, "pageSize", filter.PageSize.ToString());
            return new Uri(_endPointWithParams);
        }
    }
}