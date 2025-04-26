const puppeteer = require("puppeteer");

/*
 * Puppeteer script to activate a user interface option
 */

// org credentials
const credentials = {
  username: "test-szxxauz1kct8@example.com",
  password: "XXXXXXX"
};

(async () => {
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    userDataDir: "./userDataDir"
  });

  const page = await browser.newPage();

  await page.waitForTimeout(1000); // This will now work with Puppeteer v24.7.2

  const navigationPromise = page.waitForNavigation({ waitUntil: "networkidle0" });

  await page.goto("https://test.salesforce.com/");
  await page.setViewport({ width: 1516, height: 699 });

  await navigationPromise;

  await page.waitForSelector("body > #left #main");
  await page.click("body > #left #main");

  // Type username
  await page.waitForSelector("#login_form > #usernamegroup > #username_container #username");
  await page.type(
    "#login_form > #usernamegroup > #username_container #username",
    credentials.username
  );

  await page.waitForSelector("#wrapper > #content > #theloginform #password");
  await page.click("#wrapper > #content > #theloginform #password");

  // Type password
  await page.type(
    "#wrapper > #content > #theloginform #password",
    credentials.password
  );

  await page.waitForSelector("#wrapper > #content > #theloginform #Login");
  await page.click("#wrapper > #content > #theloginform #Login");

  await page.waitForNavigation({ waitUntil: "networkidle0" });

  // Click the gear icon
  await page.waitForSelector(
    "#oneHeader div.slds-global-header span ul li:nth-child(6) div div div.uiPopupTrigger.forceHeaderMenuTrigger div div a"
  );
  await page.click(
    "#oneHeader div.slds-global-header span ul li:nth-child(6) div div div.uiPopupTrigger.forceHeaderMenuTrigger div div a"
  );

  // Click setup (new page)
  await page.waitForSelector(".scrollable #all_setup_home a .slds-grid .slds-col");
  const newPagePromise = new Promise(x =>
    browser.once("targetcreated", target => x(target.page()))
  );
  await page.click(".scrollable #all_setup_home a .slds-grid .slds-col");

  const newPage = await newPagePromise;
  await newPage.setViewport({ width: 1516, height: 699 });

  await newPage.waitForSelector("#split-left div div div div div input");
  await newPage.click("#split-left div div div div div div input");

  // Search "User Interface"
  await newPage.type(
    "#split-left div div div div div input",
    "User Interface"
  );

  await newPage.waitForSelector("ul .leaf .slds-tree__item .slds-tree__item-label .highlight");
  await newPage.click("ul .leaf .slds-tree__item .slds-tree__item-label .highlight");

  await newPage.waitForTimeout(1000); // Now works with Puppeteer v24.7.2

  // Wait for iframe
  await newPage.waitForSelector("iframe[title*='User Interface']");

  const frames = await newPage.frames();
  const userInterfaceFrame = frames.find(f => f.url().includes("/ui/setup/org/UserInterfaceUI"));

  await userInterfaceFrame.waitForTimeout(1000); // Works here too

  await userInterfaceFrame.waitForSelector("#auditFieldInactiveOwner");
  await userInterfaceFrame.click("#auditFieldInactiveOwner");

  await userInterfaceFrame.waitForTimeout(2000);

  await userInterfaceFrame.waitForSelector("table #saveButton");
  await userInterfaceFrame.click("table #saveButton");

  await newPage.waitForTimeout(5000);

  await browser.close();
})();
