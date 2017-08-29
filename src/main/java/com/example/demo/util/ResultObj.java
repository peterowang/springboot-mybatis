package com.example.demo.util;

/**
 * Created by jiangnan on 16/8/23.
 */
public class ResultObj extends Result<Object>{
    public ResultObj(){
    	super(null, null, null);
    }
	
    public ResultObj(String code,String msg, Object data){
    	super(code, msg, data);
    }

}
