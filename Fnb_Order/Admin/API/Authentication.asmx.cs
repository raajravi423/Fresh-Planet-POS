using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Fnb_Order.Admin.API
{
    /// <summary>
    /// Summary description for Authentication
    /// </summary>
    [WebService(Namespace = "")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    //[WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
     
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class Authentication : System.Web.Services.WebService
    {

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string getStudents()
        {
            List<Student> stuList = new List<Student>();
            stuList.Add(new Student { ID = "123", Name = "Ravi Katiyar" });
          
            return JsonConvert.SerializeObject(stuList, Newtonsoft.Json.Formatting.Indented); 
        }

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        public string GetUserAuthentication(string UserName, string UserPassword)
        {
            DataTable fetchedrecords = new DataTable();

            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            SqlCommand oComm = new SqlCommand("select * from tbl_Users where UserID = '" + UserName + "' And Password = '" + UserPassword + "' and Status ='1'", oConn);
            SqlDataAdapter da = new SqlDataAdapter(oComm);
            oConn.Open();
            da.Fill(fetchedrecords);
            oConn.Close();
            if (fetchedrecords.Rows.Count > 0)
            {
                return JsonConvert.SerializeObject(true, Newtonsoft.Json.Formatting.Indented); 
            }
            else
            {
                return JsonConvert.SerializeObject(false, Newtonsoft.Json.Formatting.Indented); 
            }
        }
    }

    internal class Student
    {
        public string ID { get; set; }
        public string Name { get; set; }
    }
}
