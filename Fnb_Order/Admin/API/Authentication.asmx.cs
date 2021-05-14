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

        [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]
        public HttpStatusCode GetUserAuthentication(string UserName, string UserPassword)
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
                SessionHandler.UserID = fetchedrecords.Rows[0]["UserID"].ToString();
                SessionHandler.UserName = fetchedrecords.Rows[0]["UserName"].ToString();
                SessionHandler.UserRole = fetchedrecords.Rows[0]["UserRole"].ToString();

                return HttpStatusCode.OK;
               // Response.Redirect("/Admin/UploadRateList.aspx");
            }
            else
            {
                return HttpStatusCode.Found;
 
            }
        }
    }

    internal class Student
    {
        public string ID { get; set; }
        public string Name { get; set; }
    }
}
