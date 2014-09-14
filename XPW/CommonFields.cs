using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

namespace XPW
{
    public class ColorSupplyer
    {
        public static readonly Color[] Colors =
        {
            Color.Blue,Color.YellowGreen,Color.BlueViolet,Color.CadetBlue,
            Color.Coral,Color.Brown,Color.Chocolate,Color.DarkBlue,Color.DarkOrange,
            Color.DarkGoldenrod,Color.DarkOrchid
        };

        public static Color GenColor()
        {
            //const int r = 255;
            //const int g = 255;
            //const int b = 255;

            var rand = new Random((int)DateTime.Now.Ticks);
            //return Color.FromArgb(rand.Next(255), rand.Next(r), rand.Next(g), rand.Next(b));
            return Colors[rand.Next(Colors.Length)];
        }
    }

    public enum ChartDataType
    {
        Year,
        Month,
        Day,
        Minute
    }
}