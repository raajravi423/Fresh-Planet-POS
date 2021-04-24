using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccessLayer
{
    public class Get_Patient_Details
    {
        public string UHID { get; set; }
        public string IPID { get; set; }
        public string BEDNO { get; set; }
        public string PATIENTNAME { get; set; }
        public string ATTENDANTNAME { get; set; }        
        public string AGE { get; set; }
        public string LOCATION { get; set; }
        
    }

    public class Get_Item_List
    {
        public string ItemID { get; set; }
        public string Category { get; set; }
        public string ItemName { get; set; }
        public string Price { get; set; }

    }

}
