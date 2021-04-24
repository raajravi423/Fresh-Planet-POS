using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Fnb_Order
{
    public class SessionHandler
    {

        /// <summary>
        /// Session Properties for User ID
        /// </summary>
        private static string _UserID = "IMCLUserID";
        public static string UserID
        {
            get
            {
                if (HttpContext.Current.Session[_UserID] != null)
                {
                    return HttpContext.Current.Session[_UserID].ToString();
                }
                else
                {
                    return String.Empty;
                }

            }
            set
            {
                HttpContext.Current.Session[_UserID] = value;
            }
        }

        /// <summary>
        /// Session Properties For User Name.
        /// </summary>
        private static string _UserName = "IMCLUserName";
        public static string UserName
        {
            get
            {
                if (HttpContext.Current.Session[_UserName] != null)
                {
                    return HttpContext.Current.Session[_UserName].ToString();
                }
                else
                {
                    return String.Empty;
                }

            }
            set
            {
                HttpContext.Current.Session[_UserName] = value;
            }
        }
        /// <summary>
        /// Session Properties For User Role.
        /// </summary>
        private static string _UserRole = "IMCLUserRole";
        public static string UserRole
        {
            get
            {
                if (HttpContext.Current.Session[_UserRole] != null)
                {
                    return HttpContext.Current.Session[_UserRole].ToString();
                }
                else
                {
                    return String.Empty;
                }

            }
            set
            {
                HttpContext.Current.Session[_UserRole] = value;
            }
        }

    }
}