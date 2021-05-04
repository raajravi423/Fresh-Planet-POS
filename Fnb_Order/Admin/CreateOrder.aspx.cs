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
                BindGridview();
                gvOrderItem.Visible = false;
            }
        }      

        protected void btnSearchCustomer_Click1(object sender, EventArgs e)
            {
            DataTable DatasetcustomerDetails = new DataTable();
            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            SqlCommand oComm = new SqlCommand("usp_GetCustomerByID", oConn);
            oComm.CommandType = CommandType.StoredProcedure;
            string customerParameter = rdoCustomerType.Text.ToString();
            string searchInput = rdoCustomerType.Text.ToString()+txtCustomerID.Text.ToString().PadLeft(2, '0');
            oComm.Parameters.AddWithValue("@CustomerID ", searchInput);
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
        public static string[] getItems(string Itemname)
        {
            List<VegetablesItems> vegetablesItemsobj = new List<VegetablesItems>();
            List<string> customers = new List<string>();
            //  string cs = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            try
            { 
                DataSet DatasetcustomerDetails = new DataSet();
                VegetablesItems Vegetables = null;
              
                SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
                SqlCommand oComm = new SqlCommand("usp_GetItemsWithKeyAndItemName", oConn);
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
                        // Vegetables = new VegetablesItems();
                        // Vegetables.ItemsDbKey = Convert.ToInt32(DatasetcustomerDetails.Tables[0].Rows[i]["ID"]);
                        // Vegetables.ItemsName = Convert.ToString(DatasetcustomerDetails.Tables[0].Rows[i]["Item"]);
                        //// Vegetables.ItemsCategory = Convert.ToString(DatasetcustomerDetails.Tables[0].Rows[i]["Category"]);
                        // vegetablesItemsobj.Add(Vegetables);
                        customers.Add(string.Format("{0}-{1}", Convert.ToInt32(DatasetcustomerDetails.Tables[0].Rows[i]["ID"]), Convert.ToString(DatasetcustomerDetails.Tables[0].Rows[i]["Item"])));
                    }
                } 

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error {0}", ex.Message);
            }
            return customers.ToArray();
        }

        protected void BtnAddQuantity_Click(object sender, EventArgs e)
        {
            AddNewRow();
            //DataTable dt = new DataTable();
            //dt.Columns.Add(new DataColumn("SERIAL", Type.GetType("System.Int16")));
            //dt.Columns.Add(new DataColumn("ItemID", Type.GetType("System.Int16")));
            //dt.Columns.Add(new DataColumn("ItemName", Type.GetType("System.String")));
            //dt.Columns.Add(new DataColumn("Qty", Type.GetType("System.Decimal")));
            //dt.Columns.Add(new DataColumn("RateSlab", Type.GetType("System.Decimal")));
            //dt.Columns.Add(new DataColumn("Rate", Type.GetType("System.Decimal")));
            //dt.Columns.Add(new DataColumn("TotalAmount", Type.GetType("System.Decimal"))); 

            //DataRow row = dt.NewRow();

            //row["SERIAL"] = 1;
            //row["ItemID"] = 2;
            //row["ItemName"] = "OffPromo";
            //row["Qty"] = "3.00";
            //row["RateSlab"] = "100.00";
            //row["Rate"] = "2.00";
            //row["TotalAmount"] = "200.00";
            //dt.Rows.Add(row);

            //gvOrderItem.DataSource = dt;
            //gvOrderItem.DataBind();
        }
        private void AddNewRow()
        {
            gvOrderItem.Visible = true;
           
            int rowIndex = 0;

            if (ViewState["Curtbl"] != null)
            {
                DataTable dt = (DataTable)ViewState["Curtbl"];
               // dt.Columns.Add("",)
                DataRow drCurrentRow = null;
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        //TextBox txtname = (TextBox)gvDetails.Rows[rowIndex].Cells[1].FindControl("txtName");
                        //TextBox txtprice = (TextBox)gvDetails.Rows[rowIndex].Cells[2].FindControl("txtPrice");
                        //dt.Columns.Add("rowid", typeof(int));
                        //dt.Columns.Add(new DataColumn("SERIAL", Type.GetType("System.Int16")));
                        //dt.Columns.Add(new DataColumn("ItemID", Type.GetType("System.Int16")));
                        //dt.Columns.Add(new DataColumn("ItemName", Type.GetType("System.String")));
                        //dt.Columns.Add(new DataColumn("Qty", Type.GetType("System.Decimal")));
                        //dt.Columns.Add(new DataColumn("RateSlab", Type.GetType("System.Decimal")));
                        //dt.Columns.Add(new DataColumn("Rate", Type.GetType("System.Decimal")));
                        //dt.Columns.Add(new DataColumn("TotalAmount", Type.GetType("System.Decimal")));
                        drCurrentRow = dt.NewRow();
                        //drCurrentRow["rowid"] = i + 1;
                        drCurrentRow["SERIAL"] = i + 1;
                        drCurrentRow["ItemID"] = Convert.ToInt32(hdnItemID.Value);
                        drCurrentRow["ItemName"] = txtSelectItem.Text.ToString();
                        drCurrentRow["Qty"] = txtQuantity.Text.ToString();
                        drCurrentRow["RateSlab"] = 0.00;
                        drCurrentRow["Rate"] = 0.00; 
                        drCurrentRow["TotalAmount"] = 0.00;
                        rowIndex++;
                    }
                    dt.Rows.Add(drCurrentRow);
                    ViewState["Curtbl"] = dt;
                    gvOrderItem.DataSource = dt;
                    gvOrderItem.DataBind();
                    gvOrderItem.Rows[0].Visible = false;
                }
            }
            else
            {
                Response.Write("ViewState Value is Null");
            }
            //SetOldData();
        }
        
        protected void BindGridview()
        {
            DataTable dt = new DataTable();
          //  dt.Columns.Add("rowId", typeof(int));
            dt.Columns.Add(new DataColumn("SERIAL", Type.GetType("System.Int16")));
            dt.Columns.Add(new DataColumn("ItemID", Type.GetType("System.Int32")));
            dt.Columns.Add(new DataColumn("ItemName", Type.GetType("System.String")));
            dt.Columns.Add(new DataColumn("Qty", Type.GetType("System.Decimal")));
            dt.Columns.Add(new DataColumn("RateSlab", Type.GetType("System.Int16")));
            dt.Columns.Add(new DataColumn("Rate", Type.GetType("System.Decimal")));
            dt.Columns.Add(new DataColumn("TotalAmount", Type.GetType("System.Decimal")));

            DataRow row = dt.NewRow(); 
            //row["rowId"] = 1;
            //row["SERIAL"] = 1;
            //row["ItemID"] = 2;
            //row["ItemName"] = "OffPromo";
            //row["Qty"] = "3.00";
            //row["RateSlab"] = "100.00";
            //row["Rate"] = "2.00";
            //row["TotalAmount"] = "200.00";
            dt.Rows.Add(row);
            ViewState["Curtbl"] = dt;
          
            gvOrderItem.DataSource = dt;
            
            gvOrderItem.DataBind();
            gvOrderItem.Rows[0].Visible = false;
        }

        public void CreateFinalOrder()
        {
            DataTable DatasetcustomerDetails = new DataTable();
            DatasetcustomerDetails = (DataTable)ViewState["Curtbl"];
            DatasetcustomerDetails.Rows.RemoveAt(0);
            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
           // SqlCommand oComm = new SqlCommand("usp_CreateB2BOrder2", oConn);

            oConn.Open();
            SqlDataAdapter odb = new SqlDataAdapter();
           // odb.SelectCommand = oComm;
           // odb.Fill(DatasetcustomerDetails);
            if (DatasetcustomerDetails.Rows.Count > 0)
            {
                using (SqlConnection sqlConnection = new SqlConnection(GlobalPath.ConnectionString))
                {
                    using (SqlCommand sqlCommand = new SqlCommand("usp_CreateB2BOrder"))
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Connection = sqlConnection;
                        sqlCommand.Parameters.AddWithValue("@OrderDate",txtDate.Text.ToString());
                        sqlCommand.Parameters.AddWithValue("@CustomerID", lblCustomerID.Text.ToString());
                        sqlCommand.Parameters.AddWithValue("@ItemList", DatasetcustomerDetails);
                        sqlCommand.Parameters.AddWithValue("@CreatedBy", SessionHandler.UserID);
                        sqlConnection.Open();
                        sqlCommand.ExecuteNonQuery();
                        sqlConnection.Close();
                    }
                }
            }

            gvOrderItem.DataSource = null;
            gvOrderItem.DataBind();
            ViewState["Curtbl"] = null;
            BindGridview();
            // SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            // SqlCommand oComm = new SqlCommand("usp_CreateB2BOrder2", oConn);
            // oComm.CommandType = CommandType.StoredProcedure;
            // oComm.Parameters.AddWithValue("@OrderDate ",Convert.ToDateTime(lblOrderDate.Text).ToString("dd/mm/yyyy"));
            // oComm.Parameters.AddWithValue("@CustomerID ", txtCustomerID.Text.ToString());
            //oComm.Parameters.AddWithValue("@ItemListData ", DatasetcustomerDetails);
            // oComm.Parameters.AddWithValue("@CreatedBy ", SessionHandler.UserID);

            // SqlDataAdapter da = new SqlDataAdapter(oComm);
            // oConn.Open();
            // // da.Fill(DatasetcustomerDetails);
            // oComm.ExecuteNonQuery();
            // oConn.Close();
            //if (DatasetcustomerDetails.Rows[0] != null)
            //{

            //    lblOrderDate.Text = txtDate.Text;
            //    lblCustomerID.Text = DatasetcustomerDetails.Rows[0]["CustomerID"].ToString();
            //    lblCustomerName.Text = DatasetcustomerDetails.Rows[0]["CustomerName"].ToString();
            //    lblContactNo.Text = DatasetcustomerDetails.Rows[0]["MobileNumber"].ToString();
            //    lblAddress.Text = DatasetcustomerDetails.Rows[0]["Address"].ToString();
            //}
        }
        protected void BtnCreateOrder_Click(object sender, EventArgs e)
        {
            CreateFinalOrder();
        }

       public void BindGridAfterAdd()
        {
            DataTable dt = new DataTable();

            dt=(DataTable)ViewState["Curtbl"]; 
            gvOrderItem.DataSource = dt;
            gvOrderItem.DataBind();
            gvOrderItem.Rows[0].Visible = false;
        }

        protected void canceledit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOrderItem.EditIndex = -1;
              BindGridAfterAdd();
        }

        protected void delete(object sender, GridViewDeleteEventArgs e)
        { 
            string ItemID = gvOrderItem.Rows[1].Cells[3].Text;
            DataTable dt = new DataTable();

            dt = (DataTable)ViewState["Curtbl"];

            DataRow dr = dt.Select("ItemID=" + ItemID).FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            if (dr != null)
            {

                dr.Delete();
            }
            dt.AcceptChanges();
            gvOrderItem.EditIndex = -1;
            gvOrderItem.DataSource = dt;
            gvOrderItem.DataBind();
            gvOrderItem.Rows[0].Visible = false;

        }

        protected void Edit(object sender, GridViewEditEventArgs e)
        {
            gvOrderItem.EditIndex = e.NewEditIndex;
            BindGridAfterAdd();
        }

        protected void Update(object sender, GridViewUpdateEventArgs e)
        {
            string UpdatedQty = Convert.ToString(e.NewValues["Qty"]);
           // string ItemID = Convert.ToString(e.NewValues["ItemID"]);
            string ItemID = gvOrderItem.Rows[1].Cells[3].Text;
            DataTable dt = new DataTable();

            dt = (DataTable)ViewState["Curtbl"];
           
            DataRow dr = dt.Select("ItemID="+ ItemID).FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            if (dr != null)
            {
                
                dr["Qty"] = UpdatedQty; //changes the quantity
            }
            dt.AcceptChanges();
            gvOrderItem.EditIndex = -1;
            gvOrderItem.DataSource = dt;
            gvOrderItem.DataBind();
            gvOrderItem.Rows[0].Visible = false;
            
            //UpdatingTextBox.Text = (String)e.NewValues["Field2"];
            //DataTable dt = new DataTable();

            //dt = (DataTable)ViewState["Curtbl"];

            //string value = gvOrderItem.Rows[1].Cells[3].Text;
            //string ItrmID = gvOrderItem.Rows[1].Cells[1].Text;
            ////string value1 = gvOrderItem.Rows[1].Cells[6].Text;
            ////string value2 = gvOrderItem.Rows[1].Cells[7].Text;
            //TextBox txtname = (TextBox)gvOrderItem.Rows[1].Cells[5].FindControl("ctl00$Body$gvOrderItem$ctl03$ctl02");
            //gvOrderItem.Rows[1].Cells[3].Text = "";
            //gvOrderItem.Rows[1].Cells[3].Text = value;
        }

        //private void SetOldData()
        //{
        //    int rowIndex = 0;
        //    if (ViewState["Curtbl"] != null)
        //    {
        //        DataTable dt = (DataTable)ViewState["Curtbl"];
        //        if (dt.Rows.Count > 0)
        //        {
        //            for (int i = 0; i < dt.Rows.Count; i++)
        //            {
        //                dt.Columns.Add("rowid", typeof(int));
        //                dt.Columns.Add(new DataColumn("SERIAL", Type.GetType("System.Int16")));
        //                dt.Columns.Add(new DataColumn("ItemID", Type.GetType("System.Int16")));
        //                dt.Columns.Add(new DataColumn("ItemName", Type.GetType("System.String")));
        //                dt.Columns.Add(new DataColumn("Qty", Type.GetType("System.Decimal")));
        //                dt.Columns.Add(new DataColumn("RateSlab", Type.GetType("System.Decimal")));
        //                dt.Columns.Add(new DataColumn("Rate", Type.GetType("System.Decimal")));
        //                dt.Columns.Add(new DataColumn("TotalAmount", Type.GetType("System.Decimal")));
        //                rowIndex++;
        //            }
        //        }
        //    }
        //}
    }
}