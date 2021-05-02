<%@ Page Title="Add Customer" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddCustomer.aspx.cs" Inherits="Fnb_Order.Admin.AddCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css" >
        .main-content {
    border: 1px solid #c7c7c7;
    border-radius: 4px;
    box-shadow: 2px 2px 7px #ccc;
    height: auto;
    margin-top: 15px;
    min-height: 450px;
    overflow: auto;
    padding-bottom: 20px;
    width: 100%;
}
.dv-header {
    background-color: #f9f9f9;
    font-size: 22px;
    line-height: 50px;
}

.row {
    border-bottom: 1px solid #c7c7c7;
}


.main-header-text {
    text-align: center;
    width: 100%;
}

.text-center {
    text-align: center;
}


.form-control {
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    color: #555;
    display: block;
    font-size: 14px;
    line-height: 1.42857;
    padding: 6px 12px;
    width: 180px;
    float:left;
}


.btn {
    -moz-user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    cursor: pointer;
    display: inline-block;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857;
    margin-bottom: 0;
    padding: 6px 12px;
    text-align: center;
    vertical-align: middle;
    white-space: nowrap;
}
.btn-primary {
    background-color: #2980b9;
    border-color: #2472a4;
    color: #fff;
}

 .btn-primary:hover {
    background-color: #20638f;
    
    }


    </style>
    
    <style type="text/css">
        .tbl-default{
            width: 500px;
            margin-top:25px;

        }
        .td-default {
            float:right
        }
        .td1 {          
            width:165px;
            float:left;
            margin-right:10px;
            text-align:right;
            line-height:34px;
            overflow:auto;
            margin-bottom:15px;
             }
         .td2 {
          
            width:225px;
            float:left;

        }
        tr {
            border:1px solid black;        
        }
        .validation-msg {
         
            color:red;
            text-align:left
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
       <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Add Customer</div>
        </div>
        <div class="main-body-content">
<center>
    <asp:Label ID="lblmsg" runat="server" Font-Size="10px" ></asp:Label>
            <table class="tbl-default">
                <tr>
                    <th class="td1">
                    Customer Type:
                    </th>
                    <td class="td2">
                    <asp:DropDownList ID="ddlCustomerType" runat="server" CssClass="input-with-feedback form-control" TabIndex="0" ValidationGroup="Item" >
                        <asp:ListItem Text="Select" Selected="True" Value="0"></asp:ListItem>
                        <asp:ListItem Text="B2B" Value="B2B"></asp:ListItem>
                        <asp:ListItem Text="B2C" Value="B2C"></asp:ListItem>
                    </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvcategory" runat="server" ControlToValidate="ddlCustomerType" InitialValue="0" ErrorMessage="*" CssClass="validation-msg" ValidationGroup="Item"></asp:RequiredFieldValidator>
                    </td>
                   </tr>
                   <tr>
                    <th class="td1">
                    Customer Name:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtCustomerName" runat="server" placeholder="Customer Name" CssClass="input-with-feedback form-control" TabIndex="1" ValidationGroup="Item" ></asp:TextBox>                        
                    <asp:RequiredFieldValidator ID="rfvitemName" runat="server" ControlToValidate="txtCustomerName"  ErrorMessage="*" ValidationGroup="Item" CssClass="validation-msg"></asp:RequiredFieldValidator>
                    </td>
                    </tr>
                    <tr>
                    <th class="td1">
                    Contact Person:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtContactPerson" runat="server" placeholder="Contact Person"  CssClass="input-with-feedback form-control" TabIndex="2" ValidationGroup="Item" ></asp:TextBox>                                            
                    </td>
                </tr>
                <tr>
                <th class="td1">
                    Mobile Number:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile Number" CssClass="input-with-feedback form-control" TabIndex="3" ValidationGroup="Item"></asp:TextBox>                        
                    <asp:RegularExpressionValidator ID="rfvmobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="*" ForeColor="Red" ValidationExpression="[0-9]{10}" ValidationGroup="Item"></asp:RegularExpressionValidator>
                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Address:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtAdddress" runat="server" TextMode="MultiLine" CssClass="input-with-feedback form-control" TabIndex="4" ValidationGroup="Item" ></asp:TextBox>                        
                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Address Landmark:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtAddressLandmark" runat="server" placeholder="Address Landmark" CssClass="input-with-feedback form-control" TabIndex="5"  ValidationGroup="Item"></asp:TextBox>                        
                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Area:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtArea" runat="server" placeholder="Area" CssClass="input-with-feedback form-control" TabIndex="6" ValidationGroup="Item" ></asp:TextBox>                             
                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Location Lat:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtLocationLat" runat="server" placeholder="Location Lat" CssClass="input-with-feedback form-control" TabIndex="6" ValidationGroup="Item" ></asp:TextBox>                        
                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Location Long:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtLocationLong" runat="server"  placeholder="Location Long" CssClass="input-with-feedback form-control" TabIndex="7" ValidationGroup="Item" ></asp:TextBox>                        
                    </td>
                 </tr>
                <tr>
                <td colspan="2"><center><asp:Button ID="btnSaveItem" runat="server" CssClass="btn btn-primary" OnClick="btnSaveItem_Click" Text="Save Item" TabIndex="8" ValidationGroup="Item"  /></center> </td>
                </tr>
            </table>
    </center>
    </div>
       </div>
</asp:Content>