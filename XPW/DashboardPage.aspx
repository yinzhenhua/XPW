<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DashboardPage.aspx.cs" Inherits="XPW.DashboardPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="floatDiv leftWidth">
            <img src="Images/sd.png" />
        </div>
        <div class="floatDiv">
            <asp:Chart ID="chartEnerge" runat="server" Width="553px">
            </asp:Chart>
        </div>
    </div>
    <div style="clear: both;">
        <div class="floatDiv leftWidth co2">
            <div style="position: relative; top: 210px; width: 156px; text-align: center; font-weight: 700; font-size: 100%"><%:CO2 %>T</div>
            <div style="position: relative; top: 190px; left: 170px; width: 156px; text-align: center; font-weight: 700; font-size: 100%"><%:Trees %></div>
        </div>
        <div class="floatDiv">
            <table class="energy">
                <caption>Energy Consumption & Cost</caption>
                <colgroup>
                    <col id="cat" />
                    <col id="today" />
                    <col id="wtd" />
                    <col id="mtd" />
                    <col id="ytd" />
                </colgroup>
                <tr class="split">
                    <th scope="col"></th>
                    <th scope="col">Today</th>
                    <th scope="col">WTD</th>
                    <th scope="col">MTD</th>
                    <th scope="col">YTD</th>
                </tr>
                <tr>
                    <td class="special">Energy</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Electrictiy(KWH)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Water(m3)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Gas(m3)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr class="split">
                    <td>LN2(m3)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="special">Cost</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Electrictiy Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Water Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Gas Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>LN2 Cost(￥)</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
