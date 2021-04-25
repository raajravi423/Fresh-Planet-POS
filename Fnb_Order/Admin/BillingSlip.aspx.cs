using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DataBase;

namespace Fnb_Order.Admin
{
    public partial class BillingSlip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
         
        [WebMethod(EnableSession = true)]
        public static bool CheckSession()
        {
            if (SessionHandler.UserID == string.Empty || SessionHandler.UserID == "")
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        [WebMethod(EnableSession = true)]
        public static string GetTotalAmt(string IPID)
        {
            DataSet fetchedrecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_GetTotalBillAmt", IPID);
            if (fetchedrecords.Tables[0].Rows.Count > 0)
            {
                return fetchedrecords.Tables[0].Rows[0]["GrandTotal"].ToString();
            }
            else
            {
                return "-";
            }
        }
        //GenrateReceiptNumber
        //

        [WebMethod(EnableSession = true)]
        public static string GenrateReceiptNumber(string IPNO, string PaymentMode, string Amount, string ChequeNo, string CBankName, string CBranchName, string CMICRCode, string ChequeDate, string CaCardType, string CaCardNumber, string CaCardHolder, string CaIssuingAuthority, string CaIssuBranch, string CaAuthCode, string CaValidFrom, string CaValidUpto, string DiscountAmt, int IsSattlement)
        {
            DataSet fetchedrecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_GetReceiptNo", IPNO, PaymentMode, Amount, ChequeNo, CBankName, CBranchName, CMICRCode, ChequeDate, CaCardType, CaCardNumber, CaCardHolder, CaIssuingAuthority, CaIssuBranch, CaAuthCode, CaValidFrom, CaValidUpto, DiscountAmt, IsSattlement, SessionHandler.UserID);
            if (fetchedrecords.Tables[0].Rows.Count > 0 )
            {
                return fetchedrecords.Tables[0].Rows[0][0].ToString();
            }
            else
            {
                return "-";
            }
        }
    }
}