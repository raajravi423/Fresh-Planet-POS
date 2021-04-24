using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fnb_Order.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            ManageSession();
            btnLogOut.Click += new EventHandler(btnLogOut_Click);
        }
        private void btnLogOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("../Login.aspx");
        }

        private void ManageSession()
        {
            if (SessionHandler.UserID == "" || SessionHandler.UserID == string.Empty)
            {
                Response.Redirect("../Login.aspx");
            }
            else
            {
                //                lblDepartment.Text = SessionHandler.UserDeparetment;
                lblRole.Text = SessionHandler.UserRole;
                lblemp.Text = SessionHandler.UserName;
            }
        }
    }

}