-- 공지사항 화면
-- 관리자 공지사항

-- 1 공지사항을 누르면
-- select notice_id, notice_tit, loginId, date_format(regdate, '%Y.%m.%d') date, hit
-- 	from tb_adm_notice
--     order by notice_id desc;
--     
-- select notice_id, notice_tit, loginId, date_format(regdate, '%Y.%m.%d') date, hit
-- 	from tb_tutor_notice
--     order by notice_id desc;



-- 2 글을 누르면,
-- select notice_id, notice_tit, loginId, date_format(regdate, '%Y.%m.%d') date, hit, notice_con
-- 	from tb_adm_notice
--     where notice_id = 33
-- 	order by notice_id desc



-- 3 수정 화면
-- select notice_id, loginId, date_format(regdate, '%Y.%m.%d'), hit
-- 	from tb_adm_notice
--     where notice_id = 33


-- 강사 공지사항 --
-- select tn.notice_id, tn.notice_tit, ui.name, date_format(tn.regdate, '%Y.%m.%d') date, tn.hit
-- 	from tb_tutor_notice tn
--     left join tb_userinfo ui
--     on tn.loginId = ui.loginID
--     order by notice_id desc


-- 클릭하면
-- select tn.notice_id, tn.notice_tit, ui.name, date_format(tn.regdate, '%Y.%m.%d') date, tn.hit, tn.notice_con
-- 	from tb_tutor_notice tn
--     left join (
-- 				select name, loginId
-- 					from tb_userinfo
-- 				) ui on tn.loginId = ui.loginID
--     where tn.notice_id = 15


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 학습관리
-- 수강상담이력

-- 1 수강 상담 이력을 누르면
-- select lec_id, lec_name, concat(date_format(c_st, '%Y.%m.%d'), '~', date_format(c_end, '%Y.%m.%d')) date
-- 	from tb_lec_info;

-- 2 상담관리 과정명을 누르면
-- 조건을 달지 않았음.
-- select ta.adv_id, tli.lec_name, concat(tui.name,' (', ta.std_id, ')'), ta.adv_date, concat(tli.tutor_id, ' (', tli.tutor_name, ')') 
-- from tb_adv ta left join tb_lec_info tli
--     on ta.lec_id = tli.lec_id
--     left join tb_userinfo tui
--     on ta.std_id = tui.loginID
--     order by ta.adv_id desc

-- 수정쿼리
-- 상담 번호		수강 강의		학생 명 (ID)		상담일자		강사 (ID)
-- select ta.adv_id
-- 		,li.lec_name
--         ,concat(ui.name, ' (', ta.std_id, ')') '학생 명 (ID)'
--         ,date_format(ta.adv_date, '%Y.%m.%d') 상담일자
--         ,ta.tut_id
--         ,ui.name

-- select li.lec_name
-- 	from tb_userinfo ui
-- 		left join (
-- 						select lec_id, lec_name, tutor_name, tutor_id
-- 						from tb_lec_info
-- 					)li on ui.loginID = li.tutor_id
-- 		left join (
-- 						select adv_id, std_id, adv_date, tut_id
-- 							from tb_adv
-- 					)ta on ui.loginID = ta.std_id;

--                     
-- select *
-- 	from tb_lec_info
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 진도 관리
-- select lec_name, tutor_name, date_format(c_st, '%Y.%m.%d'), date_format(c_end, '%Y.%m.%d'), lecrm_id, pre_pnum, max_pnum
-- 	from tb_lec_info

-- select twp.week, twp.learn_con ,twp.learn_goal
-- 	from tb_week_plan twp inner join tb_lec_info tli
--     on twp.lec_id = tli.lec_id
-- 	order by twp.week

-- select concat(process_day, '일') '총 수업 수', concat(pre_day, '일') '현 수업 수', concat(truncate(pre_day / process_day * 100, 0), '%') 진행률
-- 	from tb_lec_info;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 강의 관리
-- select tli.lec_id '강의 번호', tli.lec_name 강의명, tui.name 담당교수, tli.lecrm_id 강의실, tli.pre_pnum 수강인원, concat(date_format(tli.c_st, '%Y.%m.%d'),'-', date_format(tli.c_end, '%Y.%m.%d')) 기간
-- 	from tb_lec_info tli left join tb_userinfo tui
--     on tli.tutor_id = tui.loginID
--     order by lec_id desc;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 설문조사관리
-- select  loginID '강사ID' ,name 강사명, tel '강사 전화번호', mail '강사 이메일', join_date 강의가입일
-- 	from tb_userinfo tui
--     where user_type = 'B'
--     order by mail

-- 시험 대상자 ing...
-- select tli.lec_name, tt.test_name, concat(date_format(tt.test_start, '%Y.%m.%d'), '-', tt.test_end) 시험기간, (case when tt.test_end < now() then '시험 완료' else '시험 중' end) 상태 
-- 	from tb_test tt left join tb_lec_info tli
--     on tt.lec_id = tli.lec_id
--     left join tb_test_user ttu
--     on tt.test_id = ttu.test_id;

-- 응시자 목록
-- select *
-- 	from tb_userinfo ui;
    
-- 학번	학생명	점수	상태
-- select ui.std_num
-- 		,ui.name
--         ,IFNULL(
-- 					(
-- 						SELECT tu.test_sco 
-- 							FROM tb_test_user tu 
--                             WHERE tu.test_id =(
-- 												SELECT te.test_id 
-- 													FROM tb_test te 
--                                                     WHERE tu.test_id_2 = te.test_id_2 and test_sort ='재시험'
-- 											   ) and tu.std_id = ui.loginId)
--                                                , 1000
-- 			   )AS test_sco_f 
-- 		,(
-- 			SELECT tu.pass 
-- 				FROM tb_test_user tu 
--                 WHERE tu.test_id =(
-- 									SELECT te.test_id 
-- 										FROM tb_test te 
--                                         WHERE tu.test_id_2 = te.test_id_2 and test_sort ='재시험'
-- 								   ) 
-- 				and tu.std_id = ui.loginId
-- 		  )AS pass 
-- 	from tb_test_user tu 
-- 	left outer join tb_userinfo ui on ui.loginId = tu.std_id 
-- 	WHERE tu.test_id_2 regexp "^[0-9]" and tu.test_sco < 60 and tu.test_sort ='본시험' 
--     group by ui.std_num ORDER BY ui.name;
    
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    
-- 강사 목록
-- select name 강사명, tel '강사 연락처', mail 이메일
-- 	from tb_userinfo
--     where user_type = 'B'


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 취업관리
-- 이력서 관리
-- select tli.lec_id '강의 번호', tli.lec_name 강의명, tli.tutor_name 담당교수, tli.pre_pnum 수강인원, concat(date_format(tli.c_st, '%Y.%m.%d'),' ~ ', date_format(tli.c_end, '%Y.%m.%d')) '개강일/종강일'
-- 	from tb_lec_info tli left join tb_userinfo tui
--     on tli.tutor_id = tui.loginID
--     order by lec_id


-- 취업 정보
-- select tui.std_num, tui.name, tui.tel, tli.lec_name, tui.join_date
-- 	from tb_userinfo tui left join tb_lec_info tli
--     on tui.loginID = tli.tutor_id
--     where tui.user_type = 'A'
--     order by tui.name


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 인원관리
-- 학생관리
-- select lec_id '과정 ID', lec_name '과정명 명', concat(date_format(c_st, '%Y.%m.%d'), ' ~ ', date_format(c_end, '%Y.%m.%d')) 기간
-- 	from tb_lec_info
--     order by lec_id
    
-- 학생목록
-- 전체 학생
-- select tui.std_num 학번, tli.lec_name 수강강의, concat( tui.name, ' (',tui.loginID, ')') '학생 명(ID)', tui.tel 휴대전화, tui.join_date 가입일자
-- 	from tb_userinfo tui left join tb_lecstd_info tls
--     on tui.loginID = tls.std_id
-- 	left join tb_lec_info tli
--     on tls.lec_id = tli.lec_id
--     where tui.user_type = 'A'
--     group by tui.loginID
--     order by tui.join_date

-- 미수강학생 ing....
-- select tui.std_num 학번, tli.lec_name 수강강의, concat( tui.name, ' (',tui.loginID, ')') '학생 명(ID)', tui.tel 휴대전화, tui.join_date 가입일자
-- 	from tb_userinfo tui left join tb_lecstd_info tls
--     on tui.loginID = tls.std_id
-- 	left join tb_lec_info tli
--     on tls.lec_id = tli.lec_id


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------



-- -----------------------------------------------------------팀장님 솔루션 시작------------------------------------------------------------------

-- 팀장님 쿼리
-- select li.lec_id, li.tutor_id, li.tutor_name, li.lec_name, li.pre_pnum, (select count(*) from tb_lecstd_info ls where ls.lec_id = li.lec_id) as cnt ,concat(date_format(li.c_st, '%Y.%m.%d'),' ~ ', date_format(li.c_end, '%Y.%m.%d')) cdate
-- 	from tb_lec_info li
-- 		inner join tb_userinfo ui
--         on li.tutor_id = ui.loginID and ui.user_type = 'B'
        
-- 강의명 클릭하면...	
-- select ui.name, ui.loginID, ui.tel, ui.mail, ifnull(el.wp_state, '미취업') 취업여부
-- 	from tb_lecstd_info li
--     inner join tb_userinfo ui on li.std_id = ui.loginID
--     left join tb_employ el on li.std_id = el.std_id
--     where li.lec_id = '1007';


-- 학습관리
-- 시험 대상자 관리
-- select li.lec_id
-- 		,li.lec_name
--         ,te.test_name
--         ,concat (date_format(te.test_start, '%Y.%m.%d'), '-'
--         ,date_format(te.test_end, '%Y.%m.%d')) 'due date',
--         case when te.test_end  < now() then '시험 완료' 
-- 			else '시험중' 
--         end state
--         ,ifnull(llc.cnt, 0) '대상자 수'
--         ,ifnull(llt.cnt, 0) '응시자 수'
--         -- ('대상자 수' - '응시자 수') as nocnt
--         ,(ifnull(llc.cnt, 0) - ifnull(llt.cnt, 0)) as '미응시자 수'
-- 	from tb_test te
-- 		inner join tb_lec_info li on te.lec_id = li.lec_id
--         left join 
-- 					(
-- 						select lc.lec_id, count(*) as cnt
-- 							from tb_lecstd_info lc
--                             group by lc.lec_id
-- 					) llc on li.lec_id = llc.lec_id
-- 		left join 
-- 					(
-- 						select tu.test_id, count(*) as cnt
-- 							from tb_test_user tu
--                             group by tu.test_id
-- 					) llt on te.test_id = llt.test_id
        
    
    
-- 취업 정보
-- select ui.name, ui.tel, em.employ_day 입사일, ifnull(em.resign_day, ' - ') 퇴사일, em.comp_name, em.wp_state
-- 	from tb_employ em inner join tb_userinfo ui
--     on em.std_id = ui.loginID

-- 취업 정보 등록
-- select ui.std_num ,ui.name ,ui.tel ,ll.lec_name ,ui.join_date
--   from tb_userinfo ui
--        left outer join (
--                           select li.lec_id
--                                 ,li.lec_name
--                                 ,le.std_id
--                             from tb_lecstd_info le
--                                  inner join tb_lec_info li on li.lec_id = le.lec_id
--                        ) ll on ui.loginID = ll.std_id
--  where ui.user_type = 'A'
--    and ui.loginID not in (
--                               select em.std_id
--                                 from tb_employ em
--                          )



-- 강의실
-- 강의실 관리
-- select lm.lecrm_name, lm.lecrm_size, lm.lecrm_snum, lm.lecrm_note
-- 	from tb_lecrm lm
    
-- 강의실 장비 목록

-- select  eq.equ_id, eq.equ_name, eq.equ_num, equ_note
-- 	from tb_equ eq 
--     where eq.lecrm_id= '1';

-- -----------------------------------------------------------팀장님 솔루션 끝------------------------------------------------------------------
    




