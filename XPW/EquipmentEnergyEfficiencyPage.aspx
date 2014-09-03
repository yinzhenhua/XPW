<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentEnergyEfficiencyPage.aspx.cs" Inherits="XPW.EquipmentEnergyEfficiencyPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr>
            <td colspan="2">
                <asp:Chart ID="ecpChart" runat="server" Width="800"
                    Palette="BrightPastel" BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1">
                    <Titles>
                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" Alignment="TopLeft" ShadowOffset="3" Name="ecpTitle" ForeColor="26, 59, 105"></asp:Title>
                    </Titles>
                    <Legends>
                        <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="False" Name="Default"></asp:Legend>
                    </Legends>
                    <BorderSkin SkinStyle="Emboss"></BorderSkin>
                    <Series>
                        <asp:Series Name="ecpSeries" BorderColor="180, 26, 59, 105">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ecpChartArea" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom"></asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label runat="server" ID="lblTitle"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView runat="server" ID="gvDept" AutoGenerateColumns="False" OnRowCreated="gvDept_RowCreated" OnRowDataBound="gvDept_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="ITEM">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PreviousYear" HeaderText="Previous Year">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="YTD" HeaderText="YTD">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Q1" HeaderText="Q1">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Q2" HeaderText="Q2">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Q3" HeaderText="Q3">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Q4" HeaderText="Q4">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Month1" HeaderText="">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Month2" HeaderText="">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Month3" HeaderText="">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Week1" HeaderText="Week-1">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Week2" HeaderText="Week-2">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Week3" HeaderText="Week-3">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Week4" HeaderText="Week-4">
                            <HeaderStyle Width="70px" Wrap="false" />
                            <ItemStyle Width="70px" Wrap="false" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
