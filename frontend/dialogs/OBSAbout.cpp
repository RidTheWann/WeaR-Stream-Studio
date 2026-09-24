#include "OBSAbout.hpp"

#include <widgets/OBSBasic.hpp>
#include <utility/RemoteTextThread.hpp>

#include <qt-wrappers.hpp>

#include <json11.hpp>

#include "moc_OBSAbout.cpp"

using namespace json11;

extern bool steam;

OBSAbout::OBSAbout(QWidget *parent) : QDialog(parent), ui(new Ui::OBSAbout)
{
	setWindowFlags(windowFlags() & ~Qt::WindowContextHelpButtonHint);

	ui->setupUi(this);

	QString bitness;

	if (sizeof(void *) == 4) {
		bitness = " (32 bit)";
	} else if (sizeof(void *) == 8) {
		bitness = " (64 bit)";
	}

	QString ver = obs_get_version_string();

	ui->version->setText(ver + bitness);

	ui->contribute->setText(QTStr("About.Contribute"));

	// WeaR Stream Studio (phase 3): no donation program in v1; OBS Project
	// links replaced with the fork repository. GPLv2 license text and
	// attribution to OBS Project as upstream codebase are kept below.
	delete ui->donate;

	ui->getInvolved->setText("&nbsp;&nbsp;<a href='https://github.com/RidTheWann/WeaR-Stream-Studio'>" +
				 QTStr("About.GetInvolved") + "</a>");
	ui->getInvolved->setTextInteractionFlags(Qt::TextBrowserInteraction);
	ui->getInvolved->setOpenExternalLinks(true);

	ui->about->setText("<a href='#'>" + QTStr("About") + "</a>");
	ui->authors->setText("<a href='#'>" + QTStr("About.Authors") + "</a>");
	ui->license->setText("<a href='#'>" + QTStr("About.License") + "</a>");

	ui->name->setProperty("class", "text-heading");
	ui->version->setProperty("class", "text-large");
	ui->about->setProperty("class", "bg-base");
	ui->authors->setProperty("class", "bg-base");
	ui->license->setProperty("class", "bg-base");
	ui->info->setProperty("class", "");

	connect(ui->about, &ClickableLabel::clicked, this, &OBSAbout::ShowAbout);
	connect(ui->authors, &ClickableLabel::clicked, this, &OBSAbout::ShowAuthors);
	connect(ui->license, &ClickableLabel::clicked, this, &OBSAbout::ShowLicense);

	QPointer<OBSAbout> about(this);

	// No patron feed in v1: show static fork info instead of fetching
	// OBS Project patron data.
	ShowAbout();
}

void OBSAbout::ShowAbout()
{
	QString text;

	text += "<h1>WeaR Stream Studio</h1>";
	text += "<p style=\"font-size:16px;\">";
	text += "Free and open source video recording and live streaming software.<br/>";
	text += "Based on OBS Studio by the OBS Project, licensed under GPLv2.<br/>";
	text += "<a href=\"https://github.com/RidTheWann/WeaR-Stream-Studio\">";
	text += "https://github.com/RidTheWann/WeaR-Stream-Studio</a>";
	text += "</p>";

	ui->textBrowser->setHtml(text);
}

void OBSAbout::ShowAuthors()
{
	std::string path;
	QString error =
		QTStr("About.Error").arg("https://github.com/RidTheWann/WeaR-Stream-Studio/blob/master/AUTHORS");

	if (!GetDataFilePath("authors/AUTHORS", path)) {
		ui->textBrowser->setPlainText(error);
		return;
	}

	ui->textBrowser->setPlainText(QString::fromStdString(path));

	BPtr<char> text = os_quick_read_utf8_file(path.c_str());

	if (!text || !*text) {
		ui->textBrowser->setPlainText(error);
		return;
	}

	ui->textBrowser->setPlainText(QT_UTF8(text));
}

void OBSAbout::ShowLicense()
{
	std::string path;
	QString error =
		QTStr("About.Error").arg("https://github.com/RidTheWann/WeaR-Stream-Studio/blob/master/COPYING");

	if (!GetDataFilePath("license/gplv2.txt", path)) {
		ui->textBrowser->setPlainText(error);
		return;
	}

	BPtr<char> text = os_quick_read_utf8_file(path.c_str());

	if (!text || !*text) {
		ui->textBrowser->setPlainText(error);
		return;
	}

	ui->textBrowser->setPlainText(QT_UTF8(text));
}
