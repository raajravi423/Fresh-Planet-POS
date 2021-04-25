using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
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

        [WebMethod]
        public static List<VegetablesItems> getItems(string Itemname)
        {
            List<VegetablesItems> vegetablesItemsobj = new List<VegetablesItems>();
          //  string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            try
            { 
                DataSet DatasetcustomerDetails = new DataSet();
                VegetablesItems Vegetables = null;
                SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
                SqlCommand oComm = new SqlCommand("usp_GetItemsWithKey1", oConn);
                oComm.CommandType = CommandType.StoredProcedure;
                oComm.Parameters.AddWithValue("@Key ", Itemname);                 
                SqlDataAdapter da = new SqlDataAdapter(oComm);
                oConn.Open();
                da.Fill(DatasetcustomerDetails);
                oConn.Close();
                
                if (DatasetcustomerDetails.Tables[0] != null)
                {
                    for (int i = 0; i < DatasetcustomerDetails.Tables[0].Rows.Count; i++)
                    {
                        Vegetables = new VegetablesItems();
                        Vegetables.ItemsDbKey = Convert.ToInt32(DatasetcustomerDetails.Tables[0].Rows[i]["ID"]);
                        Vegetables.ItemsName = Convert.ToString(DatasetcustomerDetails.Tables[0].Rows[i]["Item"]);
                        Vegetables.ItemsCategory = Convert.ToString(DatasetcustomerDetails.Tables[0].Rows[i]["Category"]);
                        vegetablesItemsobj.Add(Vegetables);
                    }
                } 

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error {0}", ex.Message);
            }
            return vegetablesItemsobj;
        }
    }
}