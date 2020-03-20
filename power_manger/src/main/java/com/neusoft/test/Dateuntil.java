package com.neusoft.test;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class Dateuntil {


    static String  ss="";
    static ArrayList list;
    static  int ls;
    public static void main(String[] args) {

        Calendar calendar=Calendar.getInstance();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
        ss=sdf.format( calendar.getTime());
        List list =new ArrayList();
        list.add(ss);
        System.out.println("_______________"+ list.get(0));
        ls=10001;
        Dateuntil dateuntil=new Dateuntil();
        String pch=dateuntil.getpch();
        System.out.println(pch);
    }

     public String getpch ()
     {

         SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
         Calendar calendar1=Calendar.getInstance();
         String gg=sdf.format( calendar1.getTime());

         if (!list.get(0).equals(gg))
         {

             list.set(0, gg);
             ls=10000;
         }
         ++ls;
         SimpleDateFormat sdf1=new SimpleDateFormat("yyyyMMdd");
         String ss=sdf1.format( calendar1.getTime());

         String str=ls+"";
         String pch=ss+str.substring(1);


        return pch;

     }


}
