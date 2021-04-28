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
    public partial class AddItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSaveItem_Click(object sender, EventArgs e)
        {
            string strItemCategory = string.Empty;
            string strItemName = string.Empty;
            string strItemDescription = string.Empty;
            string strMarg1KG = string.Empty;
            string strMarg5KG = string.Empty;
            string strMarg25KG = string.Empty;
            string strMarg50KG = string.Empty;
            bool isregularItem = false;

            strItemCategory = ddlCategory.SelectedItem.Value.ToString();
            strItemName = txtItemName.Text.ToString();
            strItemDescription = txtDescription.Text.ToString();
            strMarg1KG = txtMarg1Kg.Text.ToString();
            strMarg5KG = txtMarg5Kg.Text.ToString();
            strMarg25KG = txtMarg25Kg.Text.ToString();
            strMarg50KG = txtMarg50Kg.Text.ToString();

            if (chlregular.Checked == true)
            {
                isregularItem = true;
            }

            strItemCategory = ddlCategory.SelectedItem.Value.ToString();

            using (SqlConnection sqlConnection = new SqlConnection(GlobalPath.ConnectionString))
            {
                using (SqlCommand sqlCommand = new SqlCommand("usp_CRUDMasterItem"))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Connection = sqlConnection;
                    sqlCommand.Parameters.AddWithValue("@Category", strItemCategory);
                    sqlCommand.Parameters.AddWithValue("@ItemName", strItemName);
                    sqlCommand.Parameters.AddWithValue("@Description", strItemDescription);
                    sqlCommand.Parameters.AddWithValue("@Marg1Kg", strMarg1KG);
                    sqlCommand.Parameters.AddWithValue("@Marg5Kg", strMarg5KG);
                    sqlCommand.Parameters.AddWithValue("@Marg25Kg", strMarg25KG);
                    sqlCommand.Parameters.AddWithValue("@Marg50Kg", strMarg50KG);
                    sqlCommand.Parameters.AddWithValue("@IsRegular", isregularItem);
                    sqlCommand.Parameters.AddWithValue("@CreatedBy", SessionHandler.UserID);
                    sqlConnection.Open();
                     int result =  sqlCommand.ExecuteNonQuery();
                    if (result > 0)
                    {
                        lblmsg.Text = "Item Create Successfull.";
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
            ddlCategory.ClearSelection();
            txtItemName.Text = string.Empty; 
            txtDescription.Text  = string.Empty;
            txtMarg1Kg.Text =  string.Empty;
            txtMarg5Kg.Text = string.Empty;
            txtMarg25Kg.Text = string.Empty;
            txtMarg50Kg.Text = string.Empty;
            chlregular.Checked = false;
        }
    }
}