/********************************************************************************************
 *                     Author: Adán Mercado <adanmercado.dev@gmail.com>                     *
 *                     Github: https://github.com/adanmercado                               *
 ********************************************************************************************/

let CLICK_DELAY = 2000;

function Controller() {
    installer.installationFinished.connect(function() {
        gui.clickButton(buttons.NextButton, CLICK_DELAY);
    });

    installer.currentPageChanged.connect(function() {
        let widget = gui.currentPageWidget();
        console.log("Page: " + widget.objectName + " ('" + widget.title + "')");
    });
}

Controller.prototype.WelcomePageCallback = function() {
    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.CredentialsPageCallback = function() {
    let page = gui.pageWidgetByObjectName('CredentialsPage');
    page.loginWidget.EmailLineEdit.setText(QT_ACCOUNT_USERNAME);
    page.loginWidget.PasswordLineEdit.setText(QT_ACCOUNT_PASSWORD);
    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    let widget = gui.currentPageWidget();

    let archiveCheckBox = gui.findChild(widget, "Archive");
    archiveCheckBox.click();

    // Deselect LTS checkbox
    /*let ltsCheckBox = gui.findChild(widget, "Latest supported releases");
    ltsCheckBox.click();
    */
    
    let previewCheckBox = gui.findChild(widget, "Preview");
    previewCheckBox.click();

    let fetchButton = gui.findChild(widget, "FetchCategoryButton");
    if(fetchButton)
        fetchButton.click();

    let packagesToInstall = COMPONENTS;
    packagesToInstall.forEach(function(package) {
        widget.selectComponent(package);
    });

    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.TargetDirectoryPageCallback = function() {
    let widget = gui.currentPageWidget();
    widget.TargetDirectoryLineEdit.setText(QT_INSTALLATION_DIR);
    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.PerformInstallationPageCallback = function() {
    //gui.clickButton(buttons.CommitButton, CLICK_DELAY);
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.currentPageWidget().AcceptLicenseCheckBox.checked = true;
    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.ObligationsPageCallback = function() {
    let page = gui.pageWidgetByObjectName("ObligationsPage");
    page.obligationsAgreement.setChecked(true);

    let individualCheckbox = gui.findChild(page, "IndividualPerson")
    if(individualCheckbox)
        individualCheckbox.checked = true;

    page.completeChanged();
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ReadyForInstallationPageCallback = function() {
    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}

Controller.prototype.FinishedPageCallback = function() {
    // "Launch QtCreator"
    gui.currentPageWidget().RunItCheckBox.checked = RUN_QT_CREATOR;
    gui.clickButton(buttons.FinishButton, CLICK_DELAY);
}

Controller.prototype.DynamicTelemetryPluginFormCallback = function() {
    let widget = gui.currentPageWidget();
    let radioButtons = widget.TelemetryPluginForm.statisticGroupBox;
    radioButtons.disableStatisticRadioButton.checked = true;

    gui.clickButton(buttons.NextButton, CLICK_DELAY);
}
