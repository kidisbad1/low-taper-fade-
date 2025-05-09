Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Show-MadeByNick {
    $form = New-Object Windows.Forms.Form
    $form.Text = ""
    $form.Size = New-Object Drawing.Size(500, 100)
    $form.TopMost = $true
    $form.FormBorderStyle = 'None'
    $form.StartPosition = 'Manual'

    $screenBounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $form.Location = New-Object Drawing.Point(
        $screenBounds.Width - $form.Width - 105,
        $screenBounds.Height - $form.Height - 105
    )

    $label = New-Object Windows.Forms.Label
    $label.Text = "Made by Nick ;)"
    $label.ForeColor = 'Green'
    $label.Font = New-Object Drawing.Font("Segoe UI", 50, [Drawing.FontStyle]::Bold)
    $label.Dock = 'Fill'
    $label.TextAlign = 'MiddleCenter'

    $form.Controls.Add($label)
    $form.Show()
}

Show-MadeByNick

function Show-ImagePopup($imagePath) {
    $form = New-Object Windows.Forms.Form
    $form.Text = ""
    $form.Size = New-Object Drawing.Size(600, 400)
    $form.TopMost = $true
    $form.StartPosition = "Manual"

    $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $rand = New-Object System.Random
    $form.Location = New-Object System.Drawing.Point(
        $rand.Next(0, $screen.Width - $form.Width),
        $rand.Next(0, $screen.Height - $form.Height)
    )

    $pictureBox = New-Object Windows.Forms.PictureBox
    $pictureBox.Image = [Drawing.Image]::FromFile($imagePath)
    $pictureBox.SizeMode = "StretchImage"
    $pictureBox.Dock = "Fill"
    $form.Controls.Add($pictureBox)

    $form.Show()
}

function Show-CustomQuestion {
    $form = New-Object Windows.Forms.Form
    $form.Text = "Low Taper Fade Check"
    $form.Size = New-Object Drawing.Size(500, 180)
    $form.TopMost = $true
    $form.FormBorderStyle = 'FixedDialog'
    $form.StartPosition = 'Manual'

    $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $rand = New-Object System.Random
    $form.Location = New-Object Drawing.Point(
        $rand.Next(0, $screen.Width - $form.Width),
        $rand.Next(0, $screen.Height - $form.Height)
    )

    $label = New-Object Windows.Forms.Label
    $label.Text = "Is the Low Taper Fade meme massive?"
    $label.ForeColor = 'Blue'
    $label.Font = New-Object Drawing.Font("Arial", 18, [Drawing.FontStyle]::Bold)
    $label.Size = New-Object Drawing.Size(460, 60)
    $label.TextAlign = 'MiddleCenter'
    $label.Location = New-Object Drawing.Point(20, 20)

    $yesButton = New-Object Windows.Forms.Button
    $yesButton.Text = "Yes"
    $yesButton.Size = New-Object Drawing.Size(75, 30)
    $yesButton.Location = New-Object Drawing.Point(140, 100)
    $yesButton.Add_Click({ $form.Tag = "Yes"; $form.Close() })

    $noButton = New-Object Windows.Forms.Button
    $noButton.Text = "YESSS"
    $noButton.Size = New-Object Drawing.Size(75, 30)
    $noButton.Location = New-Object Drawing.Point(240, 100)
    $noButton.Add_Click({ $form.Tag = "No"; $form.Close() })

    $form.Controls.AddRange(@($label, $yesButton, $noButton))
    $form.ShowDialog() | Out-Null
    return $form.Tag
}

function Launch-PopupJob {
    Start-Job -ScriptBlock {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing

        function Show-One {
            $form = New-Object Windows.Forms.Form
            $form.Text = "Low Taper Fade Check"
            $form.Size = New-Object Drawing.Size(500, 180)
            $form.TopMost = $true
            $form.FormBorderStyle = 'FixedDialog'
            $form.StartPosition = 'Manual'

            $screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
            $rand = New-Object System.Random
            $form.Location = New-Object Drawing.Point(
                $rand.Next(0, $screen.Width - $form.Width),
                $rand.Next(0, $screen.Height - $form.Height)
            )

            $label = New-Object Windows.Forms.Label
            $label.Text = "Is the Low Taper Fade meme massive?"
            $label.ForeColor = 'Blue'
            $label.Font = New-Object Drawing.Font("Arial", 18, [Drawing.FontStyle]::Bold)
            $label.Size = New-Object Drawing.Size(460, 60)
            $label.TextAlign = 'MiddleCenter'
            $label.Location = New-Object Drawing.Point(20, 20)

            $btn = New-Object Windows.Forms.Button
            $btn.Text = "OK"
            $btn.Size = New-Object Drawing.Size(75, 30)
            $btn.Location = New-Object Drawing.Point(210, 100)
            $btn.Add_Click({ $form.Close() })

            $form.Controls.AddRange(@($label, $btn))
            $form.ShowDialog() | Out-Null
        }

        Show-One
    }
}

$answer = Show-CustomQuestion
if ($answer -eq "No") {
    1..10 | ForEach-Object { Launch-PopupJob }
}

$url = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCgy4m9W6ByWweNQlC0iVcItwuAVBlKI7PmFnEmjaFoCDTpyj2ACxi0k40Ju0PtlMK_w&usqp=CAU"
$output = [IO.Path]::Combine($env:TEMP, "low_taperfade_image.jpg")

try {
    Invoke-WebRequest -Uri $url -OutFile $output -ErrorAction Stop
    for ($i = 0; $i -lt 5; $i++) {
        Show-ImagePopup $output
    }
}
catch {
    [System.Windows.Forms.MessageBox]::Show("Failed to download image.", "Error", "OK", "Exclamation")
    exit
}

$urls = @(
    "https://www.youtube.com/watch?v=RHfJYGDxe4I"
)

Start-BouncingWarning

while ($true) {
    foreach ($link in $urls) {
        Start-Process $link
        Start-Sleep -Seconds 2
    }

    for ($i = 0; $i -lt 5; $i++) {
        Show-ImagePopup $output
    }

    Start-Sleep -Milliseconds 500
}
