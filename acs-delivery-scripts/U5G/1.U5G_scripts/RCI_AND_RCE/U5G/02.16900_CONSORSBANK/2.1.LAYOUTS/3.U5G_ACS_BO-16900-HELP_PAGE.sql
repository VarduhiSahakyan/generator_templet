USE `U5G_ACS_BO`;

SET @pageType = 'HELP_PAGE';
SET @description = 'Help Page (Consorsbank)';

/* CustomPageLayout */
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES (@pageType, @description);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType  and `description`= @description);

INSERT INTO `CustomComponent` ( `type`, `value`, `fk_id_layout`) VALUES ( 'div', '
 <div class="container-fluid">
     <div>
         <div id="helpContent">
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_HELP_PAGE_1''" id="paragraph1">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_HELP_PAGE_2''" id="paragraph2">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_HELP_PAGE_3''" id="paragraph3">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_HELP_PAGE_4''" id="paragraph4">
                 </custom-text>
             </div>
             <div class="paragraph">
                 <custom-text custom-text-key="''network_means_HELP_PAGE_5''" id="paragraph4">
                 </custom-text>
             </div>
             <div class="paragraph">
                <help-close-button help-close-label="''network_means_HELP_PAGE_11''" id="helpCloseButton"></help-close-button>
             </div>
         </div>
     </div>
 </div>

 <style>

    #help-container {
        overflow:visible;
    }

     #helpContent {
         padding: 5px 10px 0px;
         min-height: 200px;
         text-align: justify;
     }

     #helpContent #helpCloseButton div {
        display: inline;
    }

    #helpButton #help-container #helpContent #helpCloseButton button{
        font-size: 16px;
        height: 30px;
        line-height: 1.0;
        border-radius: 6px;
        background: linear-gradient(#4dbed3,#007ea5);
        box-shadow: none;
        border: 0px;
        color: #FFF;
        width: 163px;
    }

    #helpButton #help-container #helpContent #helpCloseButton button span{

        color:#FFF;
        background:inherit;
    }

    #helpButton  #help-container #helpContent #helpCloseButton span.fa-times {
        display: none;
    }

     .paragraph {
         margin: 0px 0px 10px;
         text-align: justify;
     }
 </style>
 ', @layoutId);

