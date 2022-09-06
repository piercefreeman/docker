const { chromium } = require('playwright-core');
const process = require("process");

const sleep = (ms) => {
    return new Promise((resolve) => setTimeout(resolve, ms));
};

const cleanup = () => {
    console.log("Manual kill signal received by node...")
}

process.on("SIGINT", cleanup);
process.on("SIGTERM", cleanup);

const run = async () => {
    console.log("Will launch browser...")
    const browser = await chromium.launch({
        headless: false,
        // This is set to true by default, which overrides default behavior
        // and 
        handleSIGINT: false,
        handleSIGTERM: false,
    });
    const context = await browser.newContext();
    const page = await context.newPage();

    console.log("Will launch page...");
    await page.goto("https://www.google.com");
    console.log("Did launch page");

    console.log("Sleeping...");
    await sleep(1000*60)

    console.log("Quitting browser...");
    await browser.close();
}

run();
