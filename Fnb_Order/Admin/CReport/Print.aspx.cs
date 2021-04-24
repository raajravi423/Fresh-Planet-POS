using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataBase;
namespace Fnb_Order.Admin.CReport
{
    public partial class Print : System.Web.UI.Page
    {
        public static string _BookingID;
        public static string _Flag;
        public static string _IPID;
        protected void Page_Load(object sender, EventArgs e)
        {
            _Flag = Request.QueryString["Flg"].ToString();
            _IPID = Request.QueryString["IPID"].ToString();

            if (!IsPostBack)
            {
                if (_Flag == "S1")
                {
                    PrintReportS1(_IPID);

                }
                else if (_Flag == "S2")
                {
                    PrintBillingReportS2(_IPID);

                }
                
            }
        }
        public void PrintReportS1(string IPID)
        {
            string[] splt = IPID.Split('^');
            ReportDocument doc = new ReportDocument();
            string pst = HttpContext.Current.Server.MapPath("~/Admin/CReport/PrintSlip1.rpt");
            doc.Load(pst);
            DataSet FetchedRecords = new DataSet();
            DataTable dt = new DataTable();
            FetchedRecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_GetSlipDetails", splt[0].ToString(), splt[1].ToString());
            dt = FetchedRecords.Tables[0];
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    doc.SetDataSource(dt);
                    doc.Refresh();
                    doc.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "PRINTOUT");
                }
            }
        }

        public void PrintBillingReportS2(string IPID)
        {
            string[] splt = IPID.Split('^');
            ReportDocument doc = new ReportDocument();
            string pst = string.Empty;
            if (splt[1].ToString() == "Cash")
            {
                pst = HttpContext.Current.Server.MapPath("~/Admin/CReport/BillingReceipt.rpt");
            }
            else
            {
                pst = HttpContext.Current.Server.MapPath("~/Admin/CReport/BillingReceipt1.rpt");            
            }
                doc.Load(pst);
            DataSet FetchedRecords = new DataSet();
            DataTable dt = new DataTable();
            FetchedRecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_Print_BillingSlip", splt[0].ToString());
            dt = FetchedRecords.Tables[0];
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    doc.SetDataSource(dt);
                    doc.Refresh();
                    doc.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, false, "PRINTOUT");
                }
            }
        }

    }
}