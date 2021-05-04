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
    public partial class AddCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaveItem_Click(object sender, EventArgs e)
        {
            string strCustomerType = string.Empty;
            string strCustomerName = string.Empty;
            string strContactPerson = string.Empty;
            string strMobile = string.Empty;
            string strAddress = string.Empty;
            string strAddressLandmark = string.Empty;
            string strArea = string.Empty;
            string strLocationLat = string.Empty;
            string strLocationLong = string.Empty;


            strCustomerType = ddlCustomerType.SelectedItem.Value.ToString();
            strCustomerName = txtCustomerName.Text.ToString();
            strContactPerson = txtContactPerson.Text.ToString();
            strMobile = txtMobile.Text.ToString();
            strAddress = txtAdddress.Text.ToString();
            strAddressLandmark = txtAddressLandmark.Text.ToString();
            strArea = txtArea.Text.ToString();
            strLocationLat = txtLocationLat.Text.ToString();
            strLocationLong = txtLocationLong.Text.ToString();

            using (SqlConnection sqlConnection = new SqlConnection(GlobalPath.ConnectionString))
            {
                using (SqlCommand sqlCommand = new SqlCommand("usp_CRUDMasterCustomer"))
                {

                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Connection = sqlConnection;
                    sqlCommand.Parameters.AddWithValue("@CustomerType", strCustomerType);
                    sqlCommand.Parameters.AddWithValue("@CustomerName", strCustomerName);
                    sqlCommand.Parameters.AddWithValue("@ContactPerson", strContactPerson);
                    sqlCommand.Parameters.AddWithValue("@MobileNumber", strMobile);
                    sqlCommand.Parameters.AddWithValue("@Address", strAddress);
                    sqlCommand.Parameters.AddWithValue("@AddressLandmark", strAddressLandmark);
                    sqlCommand.Parameters.AddWithValue("@Area", strArea);
                    sqlCommand.Parameters.AddWithValue("@Location_Lat", strLocationLat);
                    sqlCommand.Parameters.AddWithValue("@Location_Long", strLocationLong);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", SessionHandler.UserID);
                    sqlConnection.Open();
                    object result = sqlCommand.ExecuteScalar();
                    if (result.ToString() != "error")
                    {
                        lblmsg.Text = "Item Create Successfull. Customer ID is "+result.ToString();
                        lblmsg.ForeColor = System.Drawing.Color.Green;
                        ClearControl();
                    }
                    else
                    {
                        lblmsg.Text = "Error Occured.";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }

                    sqlConnection.Close();
                }
            }

        }
        private void ClearControl()
        {
            ddlCustomerType.ClearSelection();
            txtCustomerName.Text = string.Empty;
            txtContactPerson.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtAdddress.Text = string.Empty;
            txtAddressLandmark.Text = string.Empty;
            txtArea.Text = string.Empty;
            txtLocationLat.Text = string.Empty;
            txtLocationLong.Text = string.Empty;
        }

    }
}