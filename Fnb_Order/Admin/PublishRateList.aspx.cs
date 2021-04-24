using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fnb_Order.Admin
{
    public partial class PublishRateList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentDate = DateTime.Now.ToString("yyyy-MM-dd");
            if (!IsPostBack)
            {
                txtDate.Text = currentDate;
                GetPublishText(currentDate);
            }
        }
        protected void btngettext_Click(object sender, EventArgs e)
        {
            GetPublishText(txtDate.Text.ToString());
        }

        private void GetPublishText(string pCurrentDate)
        {
            try
            {
                DateTime currentDate = Convert.ToDateTime(pCurrentDate);

            StringBuilder stringBuilder = new StringBuilder() ; 
            DataTable fetchedrecords = new DataTable();
            SqlConnection oConn = new SqlConnection(GlobalPath.ConnectionString);
            SqlCommand oComm = new SqlCommand("usp_GetRateList", oConn);
            oComm.CommandType = CommandType.StoredProcedure;
            oComm.Parameters.AddWithValue("@ListDate", pCurrentDate);
            SqlDataAdapter da = new SqlDataAdapter(oComm);
            oConn.Open();
            da.Fill(fetchedrecords);
            oConn.Close();
            if (fetchedrecords.Rows.Count > 0)
            {
                stringBuilder.Append("*Fresh Planet Rate Board - " +currentDate.ToString("dd-MM-yy")+ "*" + "\n");
                stringBuilder.Append("(Best Quality...Best Price...Always...)" + "\n");
                stringBuilder.Append("*Join Us on WhatsApp - 8700640815*" + "\n\n");

                    for (int i = 0; i < fetchedrecords.Rows.Count; i++ )
                {
                    int serial = i + 1;
                    string itemrow = string.Empty;

                    itemrow = fetchedrecords.Rows[i]["Item"].ToString();
                    itemrow = "*" + serial.ToString() + "." + fetchedrecords.Rows[i]["Item"].ToString().Replace("\n",string.Empty).Replace("\r",string.Empty).Replace("\t", string.Empty) + "*\n";
                    itemrow = itemrow + "   ₹" + Convert.ToDecimal(fetchedrecords.Rows[i]["S_Rate_50_Kg"].ToString())+ "/Kg Qty.(50Kg or More)\n";
                    itemrow = itemrow + "   ₹" + Convert.ToDecimal(fetchedrecords.Rows[i]["S_Rate_25_Kg"].ToString()) + "/Kg Qty.(25-49Kg)\n";
                    itemrow = itemrow + "   ₹" + Convert.ToDecimal(fetchedrecords.Rows[i]["S_Rate_5_Kg"].ToString()) + "/Kg Qty.(5-24Kg)\n";
                    itemrow = itemrow + "   ₹" + Convert.ToDecimal(fetchedrecords.Rows[i]["S_Rate_1_Kg"].ToString()) + "/Kg Qty.(1-4Kg)\n";

                    stringBuilder.Append(itemrow);
                }
                    stringBuilder.Append("\n*Note:-*" + "\n");
                    stringBuilder.Append("*A.* Make Your Order Till 10:00PM, Delivery will be Next Morning 08:30AM Onwards." + "\n");
                    stringBuilder.Append("*B.* Per Item Minimum Quantity 1 KG." + "\n");
                    stringBuilder.Append("*C.* Get Free Delivery to Make Your Order 30 Kg or More." + "\n");
                    stringBuilder.Append("*D.* ₹50 Delivery Charge for Less Then 30 Kg." + "\n");

                }
                txtpublishtext.Text = stringBuilder.ToString();
        }
            catch(Exception ex)
            {

            }
            }
    }
}