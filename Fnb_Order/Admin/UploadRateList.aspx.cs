using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fnb_Order.Admin
{
    public partial class UploadRateList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void btnuploadRatelist_Click(object sender, EventArgs e)
        {
            CultureInfo provider = CultureInfo.InvariantCulture;
           string uploadedDate = txtDate.Text.ToString();
            if (furatelist.PostedFile != null)
            {
                //try
                //{
                DataTable importeddata = new DataTable();
                string path = string.Concat(Server.MapPath(@"/UploadFile/" + furatelist.FileName));
                //DirectoryInfo odirectoryInfo = new DirectoryInfo("~/UploadFile/");
                furatelist.SaveAs(path);

                //if (File.Exists(path))
                //{                  
                //}
                //else
                //{
                //}
                //Connection String to Excel Workbook
                string excelCS = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0", path);
                using (OleDbConnection con = new OleDbConnection(excelCS))
                {
                    OleDbCommand cmd = new OleDbCommand("select * from [Rates$]", con);
                    con.Open();
                    OleDbDataAdapter odb = new OleDbDataAdapter();
                    odb.SelectCommand = cmd;
                    odb.Fill(importeddata);
                    //  importeddata = ReadExcelToDatatble("Rates", path, "", 1, 0);
                    if (importeddata.Rows.Count > 0)
                    {
                    using (SqlConnection sqlConnection = new SqlConnection(GlobalPath.ConnectionString))
                    {
                        using (SqlCommand sqlCommand = new SqlCommand("usp_UploadRateList"))
                        {
                            sqlCommand.CommandType = CommandType.StoredProcedure;
                            sqlCommand.Connection = sqlConnection;
                            sqlCommand.Parameters.AddWithValue("@ListDate", uploadedDate);
                            sqlCommand.Parameters.AddWithValue("@Ratelist", importeddata);
                            sqlCommand.Parameters.AddWithValue("@CreatedBy", SessionHandler.UserID);
                            sqlConnection.Open();
                            sqlCommand.ExecuteNonQuery();
                            sqlConnection.Close();
                        }
                    }
                }
                    lblmessage.Text = "Your file uploaded successfully";
                        lblmessage.ForeColor = System.Drawing.Color.Green;
                   }
                //}
                //catch (Exception ex)
                //{
                //    lblmessage.Text = "Your file not uploaded";
                //    lblmessage.ForeColor = System.Drawing.Color.Red;
                //}
            }
        }

    
        protected void btnuploadlistagain_Click(object sender, EventArgs e)
        {
            CultureInfo provider = CultureInfo.InvariantCulture;
            string uploadedDate = txtDate.Text.ToString();
            if (furatelist.PostedFile != null)
            {
                //try
                //{
                DataTable importeddata = new DataTable();
                string path = string.Concat(Server.MapPath(@"/UploadFile/" + furatelist.FileName));
                //DirectoryInfo odirectoryInfo = new DirectoryInfo("~/UploadFile/");
                furatelist.SaveAs(path);

                //if (File.Exists(path))
                //{                  
                //}
                //else
                //{
                //}

                //Connection String to Excel Workbook
                //  string excelCS = string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0", path);
                //  using (OleDbConnection con = new OleDbConnection(excelCS))
                //  {
                //OleDbCommand cmd = new OleDbCommand("select * from [Rates$]", con);
                //con.Open();
                //OleDbDataAdapter odb = new OleDbDataAdapter();
                //odb.SelectCommand = cmd;
                //odb.Fill(importeddata);
                // importeddata =  ReadExcelToDatatble("Rates", path, "", 1, 1);

                //if (importeddata.Rows.Count > 0)
                //    {
                //        using (SqlConnection sqlConnection = new SqlConnection(GlobalPath.ConnectionString))
                //        {
                //            using (SqlCommand sqlCommand = new SqlCommand("usp_UploadRateList"))
                //            {
                //            sqlCommand.CommandType = CommandType.StoredProcedure;
                //            sqlCommand.Connection = sqlConnection;
                //            sqlCommand.Parameters.AddWithValue("@ListDate", uploadedDate);
                //            sqlCommand.Parameters.AddWithValue("@Ratelist", importeddata);
                //            sqlCommand.Parameters.AddWithValue("@CreatedBy", SessionHandler.UserID);
                //            sqlConnection.Open();
                //            sqlCommand.ExecuteNonQuery();
                //            sqlConnection.Close();
                //        }
                //        }
                //    }
                //    lblmessage.Text = "Your file uploaded successfully";
                //    lblmessage.ForeColor = System.Drawing.Color.Green;
               // }
                //}
                //catch (Exception ex)
                //{
                //    lblmessage.Text = "Your file not uploaded";
                //    lblmessage.ForeColor = System.Drawing.Color.Red;
                //}
            }
        }

        public DataTable ReadExcelToDatatble(string worksheetName, string saveAsLocation, string ReporType, int HeaderLine, int ColumnStart)
        {
            System.Data.DataTable dataTable = new DataTable();
            Microsoft.Office.Interop.Excel.Application excel;
            Microsoft.Office.Interop.Excel.Workbook excelworkBook;
            Microsoft.Office.Interop.Excel.Worksheet excelSheet;
            Microsoft.Office.Interop.Excel.Range range;
            try
            {
                // Start Excel and get Application object.
                excel = new Microsoft.Office.Interop.Excel.Application();

                // for making Excel visible
                excel.Visible = false;
                excel.DisplayAlerts = false;

                // Creation a new Workbook
                excelworkBook = excel.Workbooks.Open(saveAsLocation);

                // Workk sheet
                excelSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelworkBook.Worksheets.Item[worksheetName];
                // excelSheet.Name = worksheetName;
                range = excelSheet.UsedRange;

                int cl = range.Columns.Count;
                // loop through each row and add values to our sheet
                int rowcount = range.Rows.Count; ;

                for (int j = ColumnStart; j <= cl; j++)
                {
                    // MessageBox.Show(range.Cells[1, 1].Value2.ToString());
                    dataTable.Columns.Add(Convert.ToString(range.Cells[HeaderLine, j].Value2), typeof(string));
                }
                for (int i = HeaderLine + 1; i <= rowcount; i++)
                {
                    DataRow dr = dataTable.NewRow();
                    for (int j = ColumnStart; j <= cl; j++)
                    {
                        // MessageBox.Show(range.Cells[1, 1].Value2.ToString());

                        dr[j - ColumnStart] = Convert.ToString(range.Cells[i, j].Value2);
                    }
                    // on the first iteration we add the column headers

                    dataTable.Rows.InsertAt(dr, dataTable.Rows.Count + 1);

                }



                //now save the workbook and exit Excel

                excelworkBook.Close();
                excel.Quit();
                return dataTable;
            }
            catch (Exception ex)
            {
             //   MessageBox.Show(ex.Message);
                return null;
            }
            finally
            {
                excelSheet = null;
                range = null;
                excelworkBook = null;
            }

        }

    }
}