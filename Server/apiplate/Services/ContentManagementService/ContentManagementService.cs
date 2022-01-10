using System.Collections.Generic;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace apiplate.Services.ContentManagement
{
    public class ContentManagementService : IContentManagementService
    {
        private IWebHostEnvironment _webHostingEnvironment;
        private string path;
        private string enJsonPath;
        public ContentManagementService(IWebHostEnvironment webHostingEnvironment)
        {
            _webHostingEnvironment = webHostingEnvironment;
            path = Path.Combine(_webHostingEnvironment.WebRootPath, "assets", "contents");
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);
            enJsonPath = Path.Combine(path, "en.json");
            if (!File.Exists(enJsonPath))
            {

                File.WriteAllText(enJsonPath, "{}");
            }

        }

        public void ChangeNodeValue(string lang, string parentNode, string key, string value)
        {

            try
            {
                var jsonFile = Path.Combine(path,$"{lang}.json");
                var json = File.ReadAllText(jsonFile);
                var jsonObj = JObject.Parse(json);
                var parent = jsonObj.GetValue(parentNode);
                if (parent == null)
                    throw new System.Exception("Parent Node isn't available");
                if(parent[key] == null)
                    throw new System.Exception("Node isn't available");
                parent[key] = value;
                File.WriteAllText(jsonFile, jsonObj.ToString());


            }
            catch (System.Exception e)
            {

                throw e;
            }
        }

        public void CreateNode(string lang, string parentNode, string key, string value)
        {
            try
            {
                var jsonFile = Path.Combine(path,$"{lang}.json");
                var json = File.ReadAllText(jsonFile);
                var jsonObj = JObject.Parse(json);
                var parent = jsonObj.GetValue(parentNode);
                if (parent == null)
                    throw new System.Exception("Parent Node isn't available");
                parent[key] = value;
                File.WriteAllText(jsonFile, jsonObj.ToString());


            }
            catch (System.Exception e)
            {

                throw e;
            }
        }

        public void CreateParentNode(string lang, string node)
        {
            var jsonFile = Path.Combine(path,$"{lang}.json");
            var json = File.ReadAllText(jsonFile);
            var jsonObj = JObject.Parse(json);
            jsonObj[node] = new JObject();
            File.WriteAllText(jsonFile, jsonObj.ToString());


        }
        public void CreatNewLanguage(string langCode)
        {
            var newPath = Path.Combine(path,$"{langCode}.json");
            var enJson = File.ReadAllText(enJsonPath);
            File.WriteAllText(newPath,enJson);
                           
        }

        public void DeleteNode(string lang, string parent,string key)
        {
            var jsonFile = Path.Combine(path,$"{lang}.json");
            var json = File.ReadAllText(jsonFile);
            var jsonObj = JObject.Parse(json);
            var parentObj = (JObject)jsonObj[parent];
            parentObj.Property(key).Remove();
        
            File.WriteAllText(jsonFile, jsonObj.ToString());



        }

        public dynamic GetJsonObject(string lang)
        {
            var jsonFile = Path.Combine(path,$"{lang}.json");
            var json = File.ReadAllText(jsonFile);
            var jsonObj = JObject.Parse(json);
            return jsonObj;
        }

        public IList<string> GetLangs()
        {
                var langs = new List<string>();
                foreach (var file in Directory.GetFiles(path))
                {
                    langs.Add(Path.GetFileNameWithoutExtension(file));
                }
                return langs;
        }

        public JToken GetNode(string lang, string parent, string key)
        {
            var jsonFile = Path.Combine(path,$"{lang}.json");
            var json = File.ReadAllText(jsonFile);
            var jsonObj = JObject.Parse(json);
            return jsonObj[parent][key];
        }

        public JToken GetParent(string lang, string key)
        {

            var jsonFile = Path.Combine(path,$"{lang}.json");
            var enJson = File.ReadAllText(jsonFile);
            var jsonObj = JObject.Parse(enJson);
            return jsonObj[key];
        }
    }

}