using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public static class GlobalPath
{

    private static string _ConnectionString;
    //private static string _UserID;
    //private static string _Password;
    //private static string _UserName;


    static GlobalPath()
    {
        _ConnectionString = System.Configuration.ConfigurationManager.AppSettings["ConnectionString"].ToString();
        //_UserID = System.Configuration.ConfigurationManager.AppSettings["UserID"].ToString();
        //_Password = System.Configuration.ConfigurationManager.AppSettings["Password"].ToString();
        //_UserName = System.Configuration.ConfigurationManager.AppSettings["UserName"].ToString();

    }

    /// <summary>
    /// Properties For Global Path For Connection String For Access String Globally in Application.  
    /// </summary>
    public static string ConnectionString
    {
        get { return _ConnectionString; }
    }

    ///// <summary>
    ///// Properties For Global Path For UserID For Access String Globally in Application.
    ///// </summary>
    //public static string UserID
    //{
    //    get { return _UserID; }
    //}

    ///// <summary>
    ///// Properties For Global Path For User Password For Access String Globally in Application.
    ///// </summary>
    //public static string Password
    //{
    //    get { return _Password; }
    //}

    ///// <summary>
    ///// Properties For Global Path For User Name For Access String Globally in Application.
    ///// </summary>
    //public static string UserName
    //{
    //    get { return _UserName; }
    //}




}

