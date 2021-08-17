/*========================================================================

	----------------------------------------------------------------------
	* Date		:	
	* Name		:	
	----------------------------------------------------------------------
	
	- Description -
	01. 

========================================================================*/


$(function(){
    /*pc메뉴*/
    $(document).ready(function() {
        $('.gnb > li').on('mouseover', function(){
            $(this).find('.lnb').stop().slideDown(300);
        });
        $('.gnb > li').on('mouseout', function(){
            $(this).find('.lnb').stop().slideUp(300);
        });
    });

    
    /*모바일*/
    $(document).ready(function() {
        $('.ham_menu').on('click', function(){
            $('.m_menu_bg').css({display:'block'});
            $('.m_menu_bg').stop().animate({opacity:'1'});
            $('.m_menu_area').stop().animate({right:'0',},500);
            $('.m_menu_area').css({display:'block'});
            
            $('body').css({overflowY:'hidden'});
        });
        $('.m_menuclose, .m_menu_bg').on('click', function(){
            $('.m_menu_bg').stop().animate({opacity:'0'});
            $('.m_menu_bg').css({display:'none'});
            $('.m_menu_area').stop().animate({right:'-500px'},500);
            setTimeout(function(){
                jQuery('.m_menu_area').css({display:'none'});
            },500);
            
            $('body').css({overflowY:'scroll'});
        });
    });


});

