using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using DataBase;
using AccessLayer;
namespace Fnb_Order.Admin
{
    public partial class FnBAttendantOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Web Method For return Role Priorty.
        /// </summary>
        /// <param name="SelectedDate"></param>
        /// <returns></returns>
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

        //GetPatientDetails

        [WebMethod(EnableSession = true)]
        public static object GetPatientDetails(string BedNo)
        {
            List<Get_Patient_Details> RecordsTemplate = new List<Get_Patient_Details>();
            DataSet FetchedRecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_Get_Patient_Details", BedNo);

            if (FetchedRecords.Tables[0].Rows.Count > 0)
            {
                Get_Patient_Details RecordRow;
                for (int i = 0; i < FetchedRecords.Tables[0].Rows.Count; i++)
                {
                    RecordRow = new Get_Patient_Details();
                    RecordRow.UHID = FetchedRecords.Tables[0].Rows[i]["UHID"].ToString();
                    RecordRow.IPID = FetchedRecords.Tables[0].Rows[i]["Inpatientno"].ToString();
                    RecordRow.BEDNO = FetchedRecords.Tables[0].Rows[i]["BEDCODE"].ToString();
                    RecordRow.PATIENTNAME = FetchedRecords.Tables[0].Rows[i]["PatientName"].ToString();
                    RecordRow.ATTENDANTNAME = FetchedRecords.Tables[0].Rows[i]["Attendantname"].ToString();
                    RecordRow.AGE = FetchedRecords.Tables[0].Rows[i]["Age"].ToString();
                    RecordRow.LOCATION = FetchedRecords.Tables[0].Rows[i]["Location"].ToString();


                    RecordsTemplate.Add(RecordRow);
                }
            }
            return RecordsTemplate;
        
        }

        [WebMethod(EnableSession = true)]
        public static object GetItemList(string SearchKeyword)
        {
            List<Get_Item_List> RecordsTemplate = new List<Get_Item_List>();
            DataSet FetchedRecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_FoodItemMaster");
            if (SearchKeyword == "All")
            {
                FetchedRecords = FetchedRecords;
            }
            else {

                var filteredTable = FetchedRecords.Tables[0].Clone();
                var rows = FetchedRecords.Tables[0].Select("ItemName like '"+SearchKeyword+"%'");
                foreach (DataRow row in rows)
                {
                    filteredTable.ImportRow(row);
                }
                FetchedRecords.Tables.Remove("Table");
                FetchedRecords.Tables.Add(filteredTable);
               // return filteredTable;
            }
                

            if (FetchedRecords.Tables[0].Rows.Count > 0)    
            {
                Get_Item_List RecordRow;
                for (int i = 0; i < FetchedRecords.Tables[0].Rows.Count; i++)
                {
                    RecordRow = new Get_Item_List();
                    RecordRow.ItemID = FetchedRecords.Tables[0].Rows[i]["ItemID"].ToString();
                    RecordRow.Category = FetchedRecords.Tables[0].Rows[i]["Category"].ToString();
                    RecordRow.ItemName = FetchedRecords.Tables[0].Rows[i]["ItemName"].ToString();
                    RecordRow.Price = FetchedRecords.Tables[0].Rows[i]["Price"].ToString();
                    RecordsTemplate.Add(RecordRow);
                }
            }
            return RecordsTemplate;

        }
        
        [WebMethod(EnableSession = true)]
        public static string GenrateBill(string BEDNo, string UHID, string IPID, string PatientName, string Age, string AttendantName, string DeliveryLocation, string DOE, string DOD, string Itemstring, string SubTotal, string CGST, string SGST, string GTotal)
        {

            DataSet fetchedrecords = SqlHelper.ExecuteDataset(GlobalPath.ConnectionString, "usp_GenrateBill", BEDNo, UHID, IPID, PatientName, Age, AttendantName, DeliveryLocation, DOE, DOD, Itemstring, SubTotal, CGST, SGST, GTotal, SessionHandler.UserID);
            if (fetchedrecords.Tables[0].Rows.Count > 0)
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