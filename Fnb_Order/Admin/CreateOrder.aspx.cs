using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fnb_Order.Admin
{
    public partial class CreateOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentDate = DateTime.Now.ToString("yyyy-MM-dd");
            if (!IsPostBack)
            {
                txtDate.Text = currentDate;
            }
        }

       

        protected void btnSearchCustomer_Click1(object sender, EventArgs e)
            {
            DataTable DatasetcustomerDetails = new DataTable();
            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            SqlCommand oComm = new SqlCommand("usp_GetCustomerByID", oConn);
            oComm.CommandType = CommandType.StoredProcedure;
            oComm.Parameters.AddWithValue("@CustomerID ", txtCustomerID.Text.ToString());
            SqlDataAdapter da = new SqlDataAdapter(oComm);
            oConn.Open();
            da.Fill(DatasetcustomerDetails);

            oConn.Close();
            if( DatasetcustomerDetails.Rows[0] != null)
            {

                lblOrderDate.Text = txtDate.Text;
                lblCustomerID.Text = DatasetcustomerDetails.Rows[0]["CustomerID"].ToString();
                lblCustomerName.Text = DatasetcustomerDetails.Rows[0]["CustomerName"].ToString();
                lblContactNo.Text = DatasetcustomerDetails.Rows[0]["MobileNumber"].ToString();
                lblAddress.Text = DatasetcustomerDetails.Rows[0]["Address"].ToString();
            }

        }
    }
}