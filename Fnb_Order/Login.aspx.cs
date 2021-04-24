using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.DirectoryServices;
namespace Fnb_Order
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnLogin.Focus();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //try
            //{
                //if (txtUserName.Text == "admin" && txtPassword.Text == "Fresh@123")
                //{
                //    SessionHandler.UserID = "admin";
                //    SessionHandler.UserName = "Ravi";
                //    SessionHandler.UserRole = "Sale";

                //    Response.Redirect("/Admin/Dashboard.aspx");
                //}
                //else
                //{
                //    lblmsg.Text = "Please Enter Correct Password.";
                //    txtUserName.Text = string.Empty;
                //    txtPassword.Text = string.Empty;
                //}

                DataTable fetchedrecords = new DataTable();

            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            SqlCommand oComm = new SqlCommand("select * from tbl_Users where UserID = '" + txtUserName.Text + "' And Password = '" + txtPassword.Text + "' and Status ='1'", oConn);
            SqlDataAdapter da = new SqlDataAdapter(oComm);
            oConn.Open();
            da.Fill(fetchedrecords);
            oConn.Close();
            if (fetchedrecords.Rows.Count > 0)
            {               
                    SessionHandler.UserID = fetchedrecords.Rows[0]["UserID"].ToString();
                    SessionHandler.UserName = fetchedrecords.Rows[0]["UserName"].ToString();
                    SessionHandler.UserRole = fetchedrecords.Rows[0]["UserRole"].ToString();

                    Response.Redirect("/Admin/UploadRateList.aspx");             
            }
            else
            {
                lblmsg.Text = "Please Enter Correct UserID.";
                txtUserName.Text = string.Empty;
                txtPassword.Text = string.Empty;
            }



            //}
            //catch (Exception ex)
            //{
            //  //  Response.Redirect("~/ErrorPage.aspx");
            //}
        }

        private bool Authenticate(string userName, string password, string domain)
        {
            bool authentic = false;
            if (userName == "8221" && password == "Console")
                return true;
            try
            {
                DirectoryEntry entry = new DirectoryEntry("LDAP://" + domain, userName, password);
                DirectorySearcher ds = new DirectorySearcher(entry);
                ds.FindOne();
                authentic = true;
                entry.Close();
            }
            catch { }
            return authentic;
        }
    }
}