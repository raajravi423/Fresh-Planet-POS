<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Fnb_Order.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        * {
    margin: 0;
    padding: 0;
}

body {
    font-family: "Trebuchet MS", "Myriad Pro", Arial, sans-serif;
    font-size: 14px;
    background: #f4f4f4 url(../Images/bg.gif) repeat top left;
    color: #333;
    text-shadow: 1px 1px 1px #fff;
    overflow-y: scroll;
}

h1 {
    font-size: 56px;
}

h2 {
    font-size: 20px;
    padding: 0px 0px 40px 0px;
    color: #aaa;
}

    h2 span {
        color: #ffa800;
    }

a {
    color: #777;
}

    a:hover {
        color: #222;
    }

p {
    padding: 5px 0px;
}

.wrapper {
    width: 960px;
    margin: 20px auto;
    min-height: 550px;
}

.box {
    width: 49%;
}

.left {
    float: left;
}

.right {
    float: right;
}

.clear {
    clear: both;
}

a.back {
    color: #777;
    position: fixed;
    top: 5px;
    right: 10px;
    text-decoration: none;
}
/* Form Style */
.form_wrapper {
    background: #fff;
    border: 1px solid #ddd;
    margin: 0 auto;
    width: 350px;
    font-size: 16px;
    -moz-box-shadow: 1px 1px 7px #ccc;
    -webkit-box-shadow: 1px 1px 7px #ccc;
    box-shadow: 1px 1px 7px #ccc;
}

    .form_wrapper h3 {
        padding: 20px 30px 20px 30px;
        background-color: #01a3a3;
        color: #fff;
        font-size: 25px;
        border-bottom: 1px solid #ddd;
    }

    .form_wrapper form {
        display: none;
        background: #fff;
    }

    .form_wrapper .column {
        width: 47%;
        float: left;
    }

form.active {
    display: block;
}

form.login {
    width: 350px;
}

form.register {
    width: 550px;
}

form.forgot_password {
    width: 300px;
}

.form_wrapper a {
    text-decoration: none;
    color: #777;
    font-size: 12px;
}

    .form_wrapper a:hover {
        color: #000;
    }

.form_wrapper label {
    display: block;
    padding: 0px 30px 0px 30px;
    margin: 10px 0px 0px 0px;
}

.form_wrapper input[type="text"],
.form_wrapper input[type="password"] {
    border: solid 1px #E5E5E5;
    background: #FFFFFF;
    margin: 5px 30px 0px 30px;
    padding: 9px;
    display: block;
    font-size: 16px;
    width: 76%;
    background: -webkit-gradient( linear, left top, left 25, from(#FFFFFF), color-stop(4%, #EEEEEE), to(#FFFFFF) );
    background: -moz-linear-gradient( top, #FFFFFF, #EEEEEE 1px, #FFFFFF 25px );
    -moz-box-shadow: 0px 0px 8px #f0f0f0;
    -webkit-box-shadow: 0px 0px 8px #f0f0f0;
    box-shadow: 0px 0px 8px #f0f0f0;
}

    .form_wrapper input[type="text"]:focus,
    .form_wrapper input[type="password"]:focus {
        background: #feffef;
    }

.form_wrapper .bottom {
    background-color: #01a3a3;
    border-top: 1px solid #ddd;
    margin-top: 20px;
    clear: both;
    color: #fff;
    text-shadow: 1px 1px 1px #000;
}

    .form_wrapper .bottom a {
        display: block;
        clear: both;
        padding: 10px 30px;
        text-align: right;
        color: #ffa800;
        text-shadow: 1px 1px 1px #000;
    }

.form_wrapper a.forgot {
    float: right;
    font-style: italic;
    line-height: 24px;
    color: #ffa800;
    text-shadow: 1px 1px 1px #fff;
}

    .form_wrapper a.forgot:hover {
        color: #000;
    }

.form_wrapper div.remember {
    float: left;
    width: 140px;
    margin: 20px 0px 20px 30px;
    font-size: 11px;
}

    .form_wrapper div.remember input {
        float: left;
        margin: 2px 5px 0px 0px;
    }

.form_wrapper span.error {
    visibility: hidden;
    color: red;
    font-size: 11px;
    font-style: italic;
    display: block;
    margin: 4px 30px;
   float:right;
   width:81%;
}

.error1 {
    color: red;
    font-size: 11px;
    font-style: italic;
    display: block;
    margin: 4px 30px;
    float: right;
    width: 81%;
}
.form_wrapper .btnLogin {
    background: #e3e3e3;
    border: 1px solid #ccc;
    color: #333;
    font-family: "Trebuchet MS", "Myriad Pro", sans-serif;
    font-size: 14px;
    font-weight: bold;
    padding: 8px 0 9px;
    text-align: center;
    width: 150px;
    cursor: pointer;
    float: right;
    margin: 15px 20px 10px 10px;
    text-shadow: 0px 1px 0px #fff;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    -moz-box-shadow: 0px 0px 2px #fff inset;
    -webkit-box-shadow: 0px 0px 2px #fff inset;
    box-shadow: 0px 0px 2px #fff inset;
}

    .form_wrapper .btnLogin:hover {
        background: #d9d9d9;
        -moz-box-shadow: 0px 0px 2px #eaeaea inset;
        -webkit-box-shadow: 0px 0px 2px #eaeaea inset;
        box-shadow: 0px 0px 2px #eaeaea inset;
        color: #222;
    }

.logo {
    background-color: #01a3a3;
    color: #fff;
    font-size: 25px;
    height: 80px;
    width: 185px;
   
}



    </style>
</head>
<body>
    
    <div class="wrapper">

        <div class="content">
            <div id="form_wrapper" class="form_wrapper">
                <form runat="server" class="login active">

                    <center><img  src="Images/logo.png" class="logo" alt="Fresh Planet" /></center>
                    <h3>Login</h3>
                    <div>
                        <label>Username:</label>
                        <asp:TextBox ID="txtUserName" runat="server" TabIndex="1" CssClass="txtUserName"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID ="rfvUserName" runat="server" ControlToValidate="txtUserName" CssClass="error" ErrorMessage="Username Required." ValidationGroup ="1" ></asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <label>Password: </label>
                        <asp:TextBox ID="txtPassword" runat="server" TabIndex="2" CssClass="txtPassword"  TextMode="Password"></asp:TextBox>                       
                        <asp:RequiredFieldValidator ID ="rfvPassword" runat="server" CssClass="error" ControlToValidate="txtPassword" ErrorMessage="Password Required." ValidationGroup ="1" ></asp:RequiredFieldValidator>
                        <asp:Label ID="lblmsg" runat="server"  CssClass="error1" ></asp:Label>
                        <asp:Button ID="btnLogin" runat="server" CssClass="btnLogin" TabIndex="3" Text="Login" OnClick="btnLogin_Click" ValidationGroup ="1"  />
                        
                        <div class="clear"></div>
                    </div>
                    <%--<div>
                           <div style="width: 100%; text-align: right; font-size: 13px; margin-bottom: 5px;">
                            <p style="margin-right:5%;"><a href="Feedback.aspx" target="_blank" >Click Here</a> for Feedback Page.</p>
                            </div>
                    </div>--%>
                </form>
                
            </div>
            <div class="clear"></div>
        </div>

    </div>

</body>
</html>
