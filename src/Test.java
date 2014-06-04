import java.util.Calendar;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.dlts.bill.service.BillService;
import com.dlts.util.MD5Util;


public class Test {
	public static void main(String[] args) {
//		for(int i=0; i<10; i++){
//			System.out.println(UUID.randomUUID().toString().replace("-", ""));
//		}
//		 System.out.println("Test start.");
//	        ApplicationContext context = new ClassPathXmlApplicationContext("spring/applicationContext123.xml");
//	        //如果配置文件中将startQuertz bean的lazy-init设置为false 则不用实例化
//	        //context.getBean("startQuertz");
//	        System.out.print("Test end..");
		ApplicationContext context = new ClassPathXmlApplicationContext("spring/applicationContext*.xml");
		BillService billService = (BillService) context.getBean("billService");
		billService.updateTotalMonthCost();
	}
}
