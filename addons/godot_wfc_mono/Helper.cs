﻿/* 
 * Note: This C# script file is a slightly modified version of the same file of the same
 * name from the original work.
 * Below is the copyright notice from Maxim Gumin, the creator of the algorithm.
 * It is included as the majority of the original work has been copied over.
 * I take no credit for the creation of this algorithm; I have only slightly modified
 * it to work better with the Godot game engine.
 * 
 * The MIT License(MIT)
 * Copyright(c) mxgmn 2016.
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
 
 */

using Godot;
//using System.Linq;
//using System.Xml.Linq;
//using System.ComponentModel;
//using System.Collections.Generic;

static class Helper
{
    public static int Random(this double[] weights, double r)
    {
        double sum = 0;
        for (int i = 0; i < weights.Length; i++) sum += weights[i];
        double threshold = r * sum;

        double partialSum = 0;
        for (int i = 0; i < weights.Length; i++)
        {
            partialSum += weights[i];
            if (partialSum >= threshold) return i;
        }
        return -1;
    }

    public static long ToPower(this int a, int n)
    {
        long product = 1;
        for (int i = 0; i < n; i++) product *= a;
        return product;
    }

    //public static T Get<T>(this XElement xelem, string attribute, T defaultT = default)
    //{
    //    XAttribute a = xelem.Attribute(attribute);
    //    return a == null ? defaultT : (T)TypeDescriptor.GetConverter(typeof(T)).ConvertFromInvariantString(a.Value);
    //}

    //public static IEnumerable<XElement> Elements(this XElement xelement, params string[] names) => xelement.Elements().Where(e => names.Any(n => n == e.Name));
}
