/*========================================================================

	----------------------------------------------------------------------
	* Date		:	
	* Name		:	
	----------------------------------------------------------------------
	
	- Description -
	01. 

========================================================================*/


$(function(){
    

    /* site map */
    $(document).ready(function() {
        $('.menu-trigger').click(function () {
            $(this).toggleClass('active');

            if( $(".menu-trigger").hasClass("active") == true){
                $('.sitemap').css({display:'block'});
                $('.sitemap').stop(true).animate({opacity:'1'});

                setTimeout(function(){
                    jQuery('.sitemap>ul>li:nth-child(1)').stop(true).animate({opacity:'1', marginTop:'0'});
                },500);
                setTimeout(function(){
                    jQuery('.sitemap>ul>li:nth-child(2)').stop(true).animate({opacity:'1', marginTop:'0'});
                },600);
                setTimeout(function(){
                    jQuery('.sitemap>ul>li:nth-child(3)').stop(true).animate({opacity:'1', marginTop:'0'});
                },700);
                setTimeout(function(){
                    jQuery('.sitemap>ul>li:nth-child(4)').stop(true).animate({opacity:'1', marginTop:'0'});
                },800);
                setTimeout(function(){
                    jQuery('.sitemap>ul>li:nth-child(5)').stop(true).animate({opacity:'1', marginTop:'0'});
                },900);
                setTimeout(function(){
                    jQuery('.sitemap>ul>li:nth-child(6)').stop(true).animate({opacity:'1', marginTop:'0'});
                },1000);

                $('body').css({overflowY:'hidden'});
            }else{
                $('.sitemap').css({display:'none', opacity:'0'});
                $('.sitemap>ul>li').css({ marginTop:'-40px', opacity:'0' });

                $('body').css({overflowY:'scroll'});
            }
        });
    });

    /* 사이트맵 포커스이동 */
    $(document).ready(function() {
        $('.sitemap>ul>li:last-child>ul>li:last-child').on('focusout', function(){
            $('.ham_sitemap').removeClass('active');
            $('.sitemap').css({display:'none', opacity:'0'});
            $('.sitemap>ul>li').css({ marginTop:'-40px', opacity:'0' });
            $('body').css({overflowY:'scroll'});
        });
    });

    /* 본문 바로가기 스크립트 */
    $(document).ready(function() {
        $('.container').attr({
            "id" : "contents"
        }); 
    });

    $(document).ready(function() {
        $('.skip a').on('focus', function(){
            $(this).stop().animate({"top":0, "opacity":1});
        });
        $('.skip a').on('click', function(){
            $(this).stop().animate({"top":"-48px", "opacity":0});
        });
        $('.skip a').on('focusout', function(){
            $(this).stop().animate({"top":"-48px", "opacity":0});
        });
    });

    /* 탭키로 탑메뉴에 포커스 이동 시 메뉴 처리 스크립트 */
    $(document).ready(function() {
        $('.gnb a').on('focus', function(){
            $('.lnb').stop(true).slideDown(300);
        });

        $('.gnb a').on('focusout', function(){
            $('.lnb').stop(true).slideUp(300);
        });
    });


    

    
    /* 약관 */
    $(document).ready(function() {
        $('.btn_clause1').on('click', function(){
            $('.clause_wrap').css({display:'block'});
            $('.clause_box1').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        $('.btn_clause2').on('click', function(){
            $('.clause_wrap').css({display:'block'});
            $('.clause_box2').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        
        $('.clause_close').on('click', function(){
            $('.clause_wrap').css({display:'none'});
            $('.clause_box1').css({display:'none'});
            $('.clause_box2').css({display:'none'});
            
            $('body').css({overflowY:'scroll'});
        });
    });
    
    /* 기관기업 검색 */
    $(document).ready(function() {
        $('.btn_companySearch').on('click', function(){
            $('.companySearch_wrap').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        
        $('.companySearch_close').on('click', function(){
            $('.companySearch_wrap').css({display:'none'});
            
            $('body').css({overflowY:'scroll'});
        });
    });
    
    /* 기관기업 등록 */
    $(document).ready(function() {
        $('.add').on('click', function(){
            $('.companyRegist_wrap').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        
        $('.companyRegist_close').on('click', function(){
            $('.companyRegist_wrap').css({display:'none'});
            
            $('body').css({overflowY:'scroll'});
        });
    });
    
    
    /* 기관기업 검색 */
    $(document).ready(function() {
        $('.reservation_btn').on('click', function(){
            $('.reservation_wrap').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        
        $('.reservation_close').on('click', function(){
            $('.reservation_wrap').css({display:'none'});
            
            $('body').css({overflowY:'scroll'});
        });
    });


    /* 장비 검색 */
    $(document).ready(function(){
        $(".eqip_filter div li a").on('click',function(){
            $(this).toggleClass("on");
        });
    });
    
    
    /* 장비 검색 관심장비 */
    $(document).ready(function(){
        $(".btn_like").on('click',function(){
            $(this).toggleClass("like");
        
            if( $(".btn_like").hasClass("like") == true){
                $(this).find('img.like').css({display:'inline-block'});
                $(this).find('img.unlike').css({display:'none'});
            }else{
                $(this).find('img.like').css({display:'none'});
                $(this).find('img.unlike').css({display:'inline-block'});
            }
        });
    });


    /* FAQ */
    $(document).ready(function() {
        $('.faq a').on('click', function(){
            $('.faq_answer').stop().slideUp(300);
            $(this).nextAll('ul').find('.faq_answer').stop().slideDown(300);
        });
    });


    /* 소속회원 */
    $(document).ready(function() {
        $('.member_btn').on('click', function(){
            $('.member_wrap').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        
        $('.member_close').on('click', function(){
            $('.member_wrap').css({display:'none'});
            
            $('body').css({overflowY:'scroll'});
        });
    });


});

