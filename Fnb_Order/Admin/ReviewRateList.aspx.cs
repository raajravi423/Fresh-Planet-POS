using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace Fnb_Order.Admin
{
    public partial class ReviewRateList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentDate = DateTime.Now.ToString("yyyy-MM-dd");
            if (!IsPostBack)
            {
                txtDate.Text = currentDate;
                BindReviewRateList(currentDate);
            }
        }

        private void BindReviewRateList(string pCurrentDate)
        {
            try
            {
                DataTable fetchedrecords = new DataTable();
                SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
                SqlCommand oComm = new SqlCommand("usp_GetDatewiseRateList", oConn);
                oComm.CommandType = CommandType.StoredProcedure;
                oComm.Parameters.AddWithValue("@ListDate", pCurrentDate);
                SqlDataAdapter da = new SqlDataAdapter(oComm);
                oConn.Open();
                da.Fill(fetchedrecords);
                oConn.Close();
                if (fetchedrecords.Rows.Count > 0)
                {
                    gvReviewRateList.DataSource = fetchedrecords;
                    gvReviewRateList.DataBind();
                }
            }
            catch (Exception ex)
            {
            
            }
        }

        protected void gvReviewRateList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {               
                if (Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsReviewed")) == true)
                {
                    e.Row.BackColor = Color.Cyan;
                }

                e.Row.Cells[2].BackColor = Color.Yellow;
                e.Row.Cells[4].BackColor = Color.Yellow;
                e.Row.Cells[6].BackColor = Color.Yellow;
                e.Row.Cells[8].BackColor = Color.Yellow;

                if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR1")) > Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PR1")) && Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR1")) > 0)
                {
                    e.Row.Cells[3].BackColor = Color.Lime;
                }
                else
                {
                    e.Row.Cells[3].BackColor = Color.Red;
                }

                if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR5")) > Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PR5")) && Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR5")) > 0)
                {
                    e.Row.Cells[5].BackColor = Color.Lime;
                }
                else
                {
                    e.Row.Cells[5].BackColor = Color.Red;
                }

                if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR25")) > Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PR25")) && Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR25")) > 0)
                {
                    e.Row.Cells[7].BackColor = Color.Lime;
                }
                else
                {
                    e.Row.Cells[7].BackColor = Color.Red;
                }

                if (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR50")) > Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PR50")) && Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SR50")) > 0)
                {
                    e.Row.Cells[9].BackColor = Color.Lime;
                }
                else
                {
                    e.Row.Cells[9].BackColor = Color.Red;
                }
            }

        }

        protected void gvReviewRateList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvReviewRateList.EditIndex = e.NewEditIndex;
            BindReviewRateList(txtDate.Text.ToString());

            gvReviewRateList.Rows[e.NewEditIndex].FindControl("txtsr1").Focus();
        }

        protected void gvReviewRateList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int result = 0;
                //Finding the controls from Gridview for the row which is going to update  
                HiddenField hdnRowID = gvReviewRateList.Rows[e.RowIndex].FindControl("hdnID") as HiddenField;
                TextBox txtsr1 = gvReviewRateList.Rows[e.RowIndex].FindControl("txtsr1") as TextBox;
                TextBox txtsr5 = gvReviewRateList.Rows[e.RowIndex].FindControl("txtsr5") as TextBox;
                TextBox txtsr25 = gvReviewRateList.Rows[e.RowIndex].FindControl("txtsr25") as TextBox;
                TextBox txtsr50 = gvReviewRateList.Rows[e.RowIndex].FindControl("txtsr50") as TextBox;

                SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
                SqlCommand oComm = new SqlCommand("usp_UpdateItemWiseSaleRate", oConn);
                oComm.CommandType = CommandType.StoredProcedure;
                oComm.Parameters.AddWithValue("@RowID", hdnRowID.Value.ToString());
                oComm.Parameters.AddWithValue("@SR1", txtsr1.Text.ToString());
                oComm.Parameters.AddWithValue("@SR5", txtsr5.Text.ToString());
                oComm.Parameters.AddWithValue("@SR25", txtsr25.Text.ToString());
                oComm.Parameters.AddWithValue("@SR50", txtsr50.Text.ToString());
                oComm.Parameters.AddWithValue("@ReviewedBy", SessionHandler.UserID);

                oConn.Open();
                result = oComm.ExecuteNonQuery();
                oConn.Close();
                if (result > 0)
                {
                    gvReviewRateList.EditIndex = -1;
                    BindReviewRateList(txtDate.Text.ToString());
                }
            }
            catch (Exception ex)
            {
             
            }

        }

        protected void gvReviewRateList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvReviewRateList.EditIndex = -1;
            BindReviewRateList(txtDate.Text.ToString());
        }

        protected void gvReviewRateList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvReviewRateList.PageIndex = e.NewPageIndex;
            BindReviewRateList(txtDate.Text.ToString());
        }

        protected void btnGetRate_Click(object sender, EventArgs e)
        {
            BindReviewRateList(txtDate.Text.ToString());
        }
    }
}