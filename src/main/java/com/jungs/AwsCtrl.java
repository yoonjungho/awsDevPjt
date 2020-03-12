package com.jungs;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AwsCtrl {

	
	@RequestMapping( value="/test")  
	public String hello() {
		return "/WEB-INF/views/test.jsp";
	}
	
	
	@RequestMapping( value="/resultValue")
	@ResponseBody
	public String resultValue(HttpServletResponse response
			                 , @RequestParam int tot
			                 , @RequestParam String p_num
			                 , @RequestParam String n_num
			) throws IOException {
		
		System.out.println("asdasdas" );
		System.out.println("asdasdas");
		System.out.println("asdasdas");
		response.setContentType("text/html; charset=UTF-8");


		String [] pnum = p_num.split(",");
		String [] nnum = n_num.split(",");
		
		m_num = new ArrayList<Integer>();
		m_cnt = new ArrayList<Integer>();
		m_result = "";
		m_tot_cnt = 0;
		
		for (int i = 0; i < pnum.length; i++)  m_num.add(Integer.parseInt(pnum[i]));
		
		for (int i = 0; i < nnum.length; i++)  m_cnt.add(Integer.parseInt(nnum[i]));
		
		m_tot = tot;
//		m_num.add(10);     m_cnt.add(2);        
//		m_num.add(5);      m_cnt.add(3);        
//		m_num.add(1);      m_cnt.add(5);      
		
		
		calculation(0 , m_num.size(), m_num , m_cnt, 0 , "") ;
		m_result = "Total = [" + m_tot_cnt +"]"+ "\n" + m_result;
		System.out.println(""+m_result);
		
		
		
		
		
		
        return m_result;
	}
	
	
	ArrayList<Integer> m_num = new ArrayList<Integer>();
	ArrayList<Integer> m_cnt = new ArrayList<Integer>();
	int m_tot       = 0;
	int m_tot_cnt  = 0;
	String m_result = "";
	public void calculation(int curPos ,  int len , ArrayList<Integer> num , ArrayList<Integer> cnt, int preTot ,String preStr) 
	{
		if(curPos == len) 
		{
			System.out.println("Á¾·á");
			return;
		}
		
		int loop = cnt.get(curPos);
		
		for (int i = loop; i > -1; i--)
		{
			int t = num.get(curPos)*i + preTot;
			if(t == m_tot)
			{
				if(preStr.equals("")) m_result += m_tot + " = "                  + num.get(curPos) + " * " + i  + "\n";
				else                  m_result += m_tot + " = " + preStr + " + " + num.get(curPos) + " * " + i  + "\n";
				m_tot_cnt++;
			}
			else if(t < m_tot)
			{
				if(len != curPos+1) {
					if(preStr.equals("")) preStr =                  num.get(curPos) + " * " + i + "";
					else
					{
						if(preStr.indexOf(  num.get(curPos) + " * " + (i+1) ) > -1) {
							preStr=preStr.replace(num.get(curPos) + " * " + (i+1),num.get(curPos) + " * " + i);
						}else {
							preStr = preStr + " + " + num.get(curPos) + " * " + i + "";
						}
						
						
						
					}
					
				}else {
					break;
				}
				
				if(i == 0 && (curPos+1==len || curPos==0)) preStr = "";
				
				if(curPos+1 != len) 
				{
					calculation(curPos+1 , len, m_num , m_cnt, t , preStr) ;
				}
			}
		}
		
	}
	
}
