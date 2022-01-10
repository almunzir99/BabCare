using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace apiplate.Services.ContentManagement
{

    public interface IContentManagementService
    {
        IList<string> GetLangs();
        dynamic GetJsonObject(string lang);
        void CreatNewLanguage(string langCode);
        void CreateParentNode(string lang,string node);
        void CreateNode(string lang,string parentNode, string key, string value);
        void ChangeNodeValue(string lang,string parentNode, string key, string value);
        void DeleteNode(string lang,string parent,string key);
        JToken GetNode(string lang,string parent,string key);
        JToken GetParent(string lang,string key);

    }

}