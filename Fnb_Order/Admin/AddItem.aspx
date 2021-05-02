<%@ Page Title="Add Item" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddItem.aspx.cs" Inherits="Fnb_Order.Admin.AddItem" %>
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
            <div class="main-header-text">Add Item</div>
        </div>
        <div class="main-body-content">
<center>
    <asp:Label ID="lblmsg" runat="server" Font-Size="10px" ></asp:Label>
            <table class="tbl-default">
                <tr>
                    <th class="td1">
                    Category:
                    </th>
                    <td class="td2">
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="input-with-feedback form-control" TabIndex="0" ValidationGroup="Item" >
                        <asp:ListItem Text="Select" Selected="True" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Vegetable" Value="Vegetable"></asp:ListItem>
                        <asp:ListItem Text="Fruit" Value="Fruit"></asp:ListItem>
                    </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvcategory" runat="server" ControlToValidate="ddlCategory" InitialValue="0" ErrorMessage="*" CssClass="validation-msg" ValidationGroup="Item"></asp:RequiredFieldValidator>
                    </td>
                   </tr>
                   <tr>
                    <th class="td1">
                    Item Name:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtItemName" runat="server" placeholder="Item Name" CssClass="input-with-feedback form-control" TabIndex="1" ValidationGroup="Item" ></asp:TextBox>                        
                    <asp:RequiredFieldValidator ID="rfvitemName" runat="server" ControlToValidate="txtItemName"  ErrorMessage="*" ValidationGroup="Item" CssClass="validation-msg"></asp:RequiredFieldValidator>
                    </td>
                    </tr>
                    <tr>
                    <th class="td1">
                    Description:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtDescription" runat="server"  TextMode="MultiLine" CssClass="input-with-feedback form-control" TabIndex="2" ValidationGroup="Item" ></asp:TextBox>                                            
                    </td>
                </tr>
                <tr>
                <th class="td1">
                    Margin 1 Kg.:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtMarg1Kg" runat="server" Text="5" CssClass="input-with-feedback form-control" TabIndex="3" ValidationGroup="Item"></asp:TextBox>                        
                    <asp:RangeValidator runat="server" Type="Integer" MinimumValue="0" MaximumValue="50" ControlToValidate="txtMarg1Kg"  ErrorMessage="**" CssClass="validation-msg" ValidationGroup="Item" />
                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Margin 5 Kg.:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtMarg5Kg" runat="server" Text="4" CssClass="input-with-feedback form-control" TabIndex="4" ValidationGroup="Item" ></asp:TextBox>                        
                    <asp:RangeValidator runat="server" Type="Integer" MinimumValue="0" MaximumValue="50" ControlToValidate="txtMarg5Kg"  ErrorMessage="**" CssClass="validation-msg" ValidationGroup="Item" />

                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Margin 25 Kg.:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtMarg25Kg" runat="server" Text="3" CssClass="input-with-feedback form-control" TabIndex="5"  ValidationGroup="Item"></asp:TextBox>                        
                    <asp:RangeValidator runat="server" Type="Integer" MinimumValue="0" MaximumValue="50" ControlToValidate="txtMarg25Kg"  ErrorMessage="**" CssClass="validation-msg" ValidationGroup="Item" />

                    </td>
                 </tr>
                <tr>
                <th class="td1">
                    Margin 50 Kg.:
                    </th>
                    <td class="td2">
                    <asp:TextBox ID="txtMarg50Kg" runat="server" Text="2" CssClass="input-with-feedback form-control" TabIndex="6" ValidationGroup="Item" ></asp:TextBox>                        
                    <asp:RangeValidator runat="server" Type="Integer" MinimumValue="0" MaximumValue="50" ControlToValidate="txtMarg50Kg"  ErrorMessage="**" CssClass="validation-msg" ValidationGroup="Item" />

                    </td>
                 </tr>
                 <th class="td1">
                    
                    </th>
                    <td class="td2">
                    <asp:CheckBox ID="chlregular" runat="server" Text="Is this in Regular Category.?" TextAlign="Right"  />
                     </td>
                 </tr>
                <tr>
                <td colspan="2" > <center><asp:Button ID="btnSaveItem" runat="server" CssClass="btn btn-primary" Text="Save Item" TabIndex="7" ValidationGroup="Item" OnClick="btnSaveItem_Click" /></center> </td>
                </tr>


            </table>
    </center>
    </div>
       </div>
</asp:Content>