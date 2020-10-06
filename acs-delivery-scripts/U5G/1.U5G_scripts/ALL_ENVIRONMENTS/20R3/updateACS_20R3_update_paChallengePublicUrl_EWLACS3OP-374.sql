/* Updated to be compatible with the new format for sticky sessions */

UPDATE SubIssuer SET paChallengePublicUrl=REPLACE(paChallengePublicUrl,paChallengePublicUrl,CONCAT('{ "Vendome" : "',paChallengePublicUrl,'", "Seclin" : "',paChallengePublicUrl,'", "Unknown" : "',paChallengePublicUrl,'" }')) WHERE paChallengePublicUrl LIKE "http%";