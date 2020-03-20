package com.neusoft.until;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class DateConvert implements Converter<String,Date> {

    SimpleDateFormat[]simpleDateFormats=new SimpleDateFormat[]{
               new SimpleDateFormat("yyyy-MM-dd"),
               new SimpleDateFormat("yyyy/MM/dd"),
               new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"),
               new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"),
    };
    @Override
    public Date convert(String s) {
        Date date=new Date();

         for (SimpleDateFormat sdf:simpleDateFormats
                 ) {
                try {
                 date=sdf.parse(s);
                }catch (Exception e)
                {
                    continue;
                }
            }


        return date;
    }
}
