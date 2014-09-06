﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentEnergyEfficiencyPage.aspx.cs" Inherits="XPW.EquipmentEnergyEfficiencyPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link type="text/css" rel="stylesheet" href="Content/GridView.css" />
    <div class="moduleDIV">
        <h2>
            <asp:Label runat="server" ID="lblTitle"></asp:Label>
        </h2>
        <table>
            <tr>
                <td colspan="2">
                    <div style="overflow-x: scroll; height: 235px; width: 940px" id="dvBody">
                        <asp:GridView runat="server" ID="gvDept" AutoGenerateColumns="False"
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt"
                            OnRowCreated="gvDept_RowCreated" OnRowDataBound="gvDept_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="ITEM">
                                    <ItemStyle Width="22%" Wrap="false" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PreviousYear" HeaderText="Previous Year">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="YTD" HeaderText="YTD">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q1" HeaderText="Q1">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q2" HeaderText="Q2">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q3" HeaderText="Q3">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q4" HeaderText="Q4">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Month1" HeaderText="">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Month2" HeaderText="">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Month3" HeaderText="">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week1" HeaderText="Week-1">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week2" HeaderText="Week-2">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week3" HeaderText="Week-3">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week4" HeaderText="Week-4">
                                    <ItemStyle Width="6%" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Chart ID="ecpChart" runat="server" Width="940"
                        Palette="BrightPastel" BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1">
                        <Titles>
                            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" Alignment="TopLeft" ShadowOffset="3" Name="ecpTitle" ForeColor="26, 59, 105"></asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss"></BorderSkin>
                        <Legends>
                            <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                Alignment="Center" Docking="Bottom">
                            </asp:Legend>
                            <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                Alignment="Center" Docking="Bottom">
                            </asp:Legend>
                        </Legends>
                        <Series>
                            <asp:Series Name="Efficiency" BorderColor="180, 26, 59, 105" Color="#4f81bd">
                            </asp:Series>
                            <asp:Series Name="Baseline" BorderColor="180, 26, 59, 105" Color="#00b050">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ecpChartArea" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom"></asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </td>
            </tr>

        </table>
    </div>

</asp:Content>
