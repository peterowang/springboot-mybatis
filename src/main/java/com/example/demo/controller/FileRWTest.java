package com.example.demo.controller;

import org.apache.commons.lang3.StringUtils;

import java.io.*;

/**
 * Created by BFD-593 on 2017/8/29.
 */
public class FileRWTest {
    public static void main(String[] args) throws Exception{

        System.out.println(RWTest2.test());
        StringBuffer sb = new StringBuffer("工工工工");
        sb.append("苦村顶戴");
        System.out.println(sb.toString());
    }
}
class RWTest1 {
   public static void Test1() throws Exception{
        FileReader fr1 = new FileReader("D:/1.txt");
        BufferedReader br1 = new BufferedReader(fr1);
        String str = "";
        String str1 = "";
        String str2 = "";
        StringBuffer sb = new StringBuffer();
        while((str1=br1.readLine())!=null){
        FileReader fr2 = new FileReader("D:/2.txt");
        BufferedReader br2 = new BufferedReader(fr2);
        boolean flag = false;
        FileWriter fw = null;
        BufferedWriter bw = null;
        fw = new FileWriter("D:/3.txt");
        bw = new BufferedWriter(fw);
        while ((str2 = br2.readLine()) != null) {
        String[] split = str2.split(",");
        if(str1.equals(split[0])){
        str = sb.append(str1).append("\t").append(split[1]).append("\t").append(split[2]).
        append("\t").append(split[3]).append("\n").toString();
        System.out.println(str);flag = true;
        bw.write(str);
        bw.close();
        break;
        }
        }
        if(!flag){
        str = sb.append("\n").toString();
        bw.write(str);
        bw.close();
        }
        br2.close();
        }
        br1.close();
        }

}
class RWTest2{
    public static String test() throws Exception{
        FileReader fr = new FileReader("D:/1.txt");
        BufferedReader reader = new BufferedReader(fr);
        StringBuffer sb = new StringBuffer();
        String str = "";
        int index = 0;
        String tableName = "";
        String comment = "";
        while ((str = reader.readLine()) != null) {
            if (index == 0) {
                tableName = str;
                sb.append("drop table if exists " + str + "\n");
                sb.append("create table " + str + "(\n");
            }else{
                String[] split = str.split("\t");
                comment = comment + appendSql(tableName,sb, split);
            }
            index++;
        }
        fr.close();
        reader.close();
        sb.append(");\n");
        sb.append(comment);

        File file = new File("D:/2.txt");
        OutputStream out = null;
        try {
            out = new FileOutputStream(file);
            out.write(sb.toString().getBytes());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(out!=null){
                out.close();
            }
        }
        String result=new String(sb.toString().getBytes(),"UTF-8");
        return result;
    }

    public static String appendSql(String tableName,StringBuffer sb1 ,String[] split){
        String str = "";
        if(split.length>2){
            String type = StringUtils.containsIgnoreCase(split[2], "varchar") ? "varchar" : split[2];
            sb1.append(split[0] + " " + type + ",\n");
            str = str + "comment on column " + tableName + "." + split[0] + " is " + split[1] + ";\n";
        }else{
            String type = StringUtils.containsIgnoreCase(split[1], "varchar") ? "varchar" : split[1];
            sb1.append(split[0] + " " + type + ",\n");
        }
        return str;
    }
}