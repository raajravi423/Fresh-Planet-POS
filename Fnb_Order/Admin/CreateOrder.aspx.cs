using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
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

        public void clearControls()
        {
            lblCustomerID.Text = string.Empty;
            lblOrderDate.Text = string.Empty;
            lblCustomerName.Text= string.Empty;

            lblContactNo.Text = string.Empty;
            lblAddress.Text = "No data Exist";
        }
        protected void btnSearchCustomer_Click1(object sender, EventArgs e)
        {
            lblOrderMsg.Visible = false;
            lblSearchMsg.Visible = false;
            DataTable DatasetcustomerDetails = new DataTable();
            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            SqlCommand oComm = new SqlCommand("usp_GetCustomerByID", oConn);
            oComm.CommandType = CommandType.StoredProcedure;
            string customerParameter = rdoCustomerType.Text.ToString();
            string searchInput = rdoCustomerType.Text.ToString() + txtCustomerID.Text.ToString().PadLeft(2, '0');
            oComm.Parameters.AddWithValue("@CustomerID ", searchInput);
            SqlDataAdapter da = new SqlDataAdapter(oComm);
            oConn.Open();
            da.Fill(DatasetcustomerDetails);

            oConn.Close();

            if( DatasetcustomerDetails.Rows.Count > 0)

            {

                lblOrderDate.Text = txtDate.Text;
                lblCustomerID.Text = DatasetcustomerDetails.Rows[0]["CustomerID"].ToString();
                lblCustomerName.Text = DatasetcustomerDetails.Rows[0]["CustomerName"].ToString();
                lblContactNo.Text = DatasetcustomerDetails.Rows[0]["MobileNumber"].ToString();
                lblAddress.Text = DatasetcustomerDetails.Rows[0]["Address"].ToString();
                pnlcustomerdetail.Visible = true;

            }
            else
            {
                clearControls();
                pnlcustomerdetail.Visible = false;

                //spa myTextboxControl = (Label)Page.f("Body_lblSearchMsg");
                //Label LabelMsg = this.Master.FindControl("Body").FindControl("lblSearchMsg") as Label;

                lblSearchMsg.Visible = true;
                lblSearchMsg.Text = "";
                lblSearchMsg.Text = "Customer Not Found";
            }

        }

        [WebMethod]
        public static string[] getItems(string Itemname)
        {
            List<VegetablesItems> vegetablesItemsobj = new List<VegetablesItems>();
            List<string> customers = new List<string>();
        
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
            lblOrderMsg.Visible = false;
            AddNewRow();
        
        }
        private void AddNewRow()
        {
          
            gvOrderItem.Visible = true;

            int rowIndex = 0;

            if (ViewState["Curtbl"] != null)
            {
                DataTable dt = (DataTable)ViewState["Curtbl"];

                DataRow drCurrentRow = null;
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {             
                        drCurrentRow = dt.NewRow();                
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
        }

        protected void BindGridview()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("SERIAL", Type.GetType("System.Int16")));
            dt.Columns.Add(new DataColumn("ItemID", Type.GetType("System.Int32")));
            dt.Columns.Add(new DataColumn("ItemName", Type.GetType("System.String")));
            dt.Columns.Add(new DataColumn("Qty", Type.GetType("System.Decimal")));
            dt.Columns.Add(new DataColumn("RateSlab", Type.GetType("System.Int16")));
            dt.Columns.Add(new DataColumn("Rate", Type.GetType("System.Decimal")));
            dt.Columns.Add(new DataColumn("TotalAmount", Type.GetType("System.Decimal")));

            DataRow row = dt.NewRow();
            dt.Rows.Add(row);
            ViewState["Curtbl"] = dt;
            gvOrderItem.DataSource = dt;
            gvOrderItem.DataBind();
            gvOrderItem.Rows[0].Visible = false;
            gvOrderItem.ShowFooter = true;
        }

        public void CreateFinalOrder()
        {
            DataTable DatasetcustomerDetails = new DataTable();
            DatasetcustomerDetails = (DataTable)ViewState["Curtbl"];

            if (DatasetcustomerDetails.Rows.Count > 1)
            {
                DatasetcustomerDetails.Rows.RemoveAt(0);
                SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
                oConn.Open();
                SqlDataAdapter odb = new SqlDataAdapter();
                if (DatasetcustomerDetails.Rows.Count > 0)
                {
                    using (SqlConnection sqlConnection = new SqlConnection(GlobalPath.ConnectionString))
                    {
                        using (SqlCommand sqlCommand = new SqlCommand("usp_CreateB2BOrder"))
                        {
                            sqlCommand.CommandType = CommandType.StoredProcedure;
                            sqlCommand.Connection = sqlConnection;
                            sqlCommand.Parameters.AddWithValue("@OrderDate", txtDate.Text.ToString());
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
                lblOrderMsg.Visible = true;
                lblOrderMsg.InnerText = "Order Created Successfully!";
                txtSelectItem.Text = string.Empty;
                txtQuantity.Text = string.Empty;
            }else
            {
                lblOrderMsg.Visible = true;
                lblOrderMsg.InnerText = "Please give the Order First!";
            }

          
        }
        protected void BtnCreateOrder_Click(object sender, EventArgs e)
        {
            CreateFinalOrder();
        }

        public void BindGridAfterAdd()
        {
            DataTable dt = new DataTable();

            dt = (DataTable)ViewState["Curtbl"];
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
            string ItemID = gvOrderItem.Rows[1].Cells[1].Text;
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
            string ItemID = gvOrderItem.Rows[1].Cells[1].Text;
            DataTable dt = new DataTable();
            dt = (DataTable)ViewState["Curtbl"];
            DataRow dr = dt.Select("ItemID=" + ItemID).FirstOrDefault(); // finds all rows with id==2 and selects first or null if haven't found any
            if (dr != null)
            {

                dr["Qty"] = UpdatedQty; //changes the quantity
            }
            dt.AcceptChanges();
            gvOrderItem.EditIndex = -1;
            gvOrderItem.DataSource = dt;
            gvOrderItem.DataBind();
            gvOrderItem.Rows[0].Visible = false;
        }
        int totalqty = 0;
        //protected void gvOrderItem_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        totalqty += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Qty"));
        //    }
        //    if (e.Row.RowType == DataControlRowType.Footer)
        //    {
        //        Label lblamount = (Label)e.Row.FindControl("lbltotalqty");
        //        lblamount.Text = totalqty.ToString();
        //    }
        //}

        private void gettotalquantuty() 
        {
           
        }

        //Variable to hold the total value
        int totalvalue = 0;
        protected void gvOrderItem_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(DataBinder.Eval(e.Row.DataItem, "Qty") != DBNull.Value)
            { 
                //Check if the current row is datarow or not
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //Add the value of column
                    totalvalue += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Qty"));
                }
                if (e.Row.RowType == DataControlRowType.Footer)
                {
                    //Find the control label in footer 
                    Label lblamount = (Label)e.Row.FindControl("lblTotalQty");
                    //Assign the total value to footer label control
                    lblamount.Text = "Total Value is : " + totalvalue.ToString();
                }
            }
        }
    }
}