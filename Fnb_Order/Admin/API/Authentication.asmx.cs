using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Fnb_Order.Admin.API
{
    /// <summary>
    /// Summary description for Authentication
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Authentication : System.Web.Services.WebService
    {

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getStudents()
        {
            List<Student> stuList = new List<Student>();
            stuList.Add(new Student { ID = "123", Name = "Ravi Katiyar" });
           // return JsonConvert.SerializeObject(stuList);
            System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();

            return js.Serialize(stuList);

            //   return stuList;
        }
    }

    internal class Student
    {
        public string ID { get; set; }
        public string Name { get; set; }
    }
}
