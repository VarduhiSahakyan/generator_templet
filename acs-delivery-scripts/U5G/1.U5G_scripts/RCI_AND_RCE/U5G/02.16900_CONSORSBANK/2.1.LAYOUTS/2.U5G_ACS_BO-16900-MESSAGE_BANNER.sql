USE `U5G_ACS_BO`;

SET @pageType = 'MESSAGE_BANNER';
SET @description = 'Message Banner (Consorsbank)';

/* CustomPageLayout */
INSERT INTO `CustomPageLayout` (`pageType`, `description`) VALUES (@pageType, @description);

SET @layoutId = (SELECT id FROM `CustomPageLayout` WHERE `pageType`= @pageType  and `description`= @description);

INSERT INTO `CustomComponent` ( `type`, `value`, `fk_id_layout`) VALUES ( 'div', '<div id="messageBanner">
          <span id="info-icon" class="fa fa-info-circle"></span>
          <custom-text class="message  headingTxt" custom-text-key="$parent.heading"></custom-text>
          <custom-text class="message" custom-text-key="$parent.message"></custom-text>

          <style>
              span#info-icon {
                  position:absolute;
                  top:10px;
                  left:15px;
                  float:none;
              }

              div#message-container {
                 position:relative;
                 background-color:#F5F5F5;
                  color: #464646;
              }

              .headingTxt {
                font-weight: bold;
              }
              .message {
                  text-align:left;
                  margin-bottom:10px;
                  display: block;
                  margin-left:80px;

              }

                div#message-container.error {
                    color:#FF5A64;
               }

              div#message-container.success {
                    color: #00915E;
                }

                div#message-container.info {
                    color: #0080A6;
                }

              #optGblPage message-banner div#message-container {
                  width:100% ;
                  box-shadow: none ;
                  -webkit-box-shadow:none;
                  position: relative;
              }

              #message-content {
                padding-top:10px;
               }
          </style>
      </div>
', @layoutId);

