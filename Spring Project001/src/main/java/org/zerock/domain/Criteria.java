package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/* pageNum과 amount 전달 클래스*/
@Setter
@Getter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	
	public Criteria() {
		this(1,10);
	}
	public Criteria(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
