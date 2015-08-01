<?php

class OC_Theme {

	private $themeEntity;
	private $themeName;
	private $themeTitle;
	private $themeBaseUrl;
	private $themeDocBaseUrl;
	private $themeSyncClientUrl;
	private $themeSlogan;
	private $themeMailHeaderColor;

	function __construct() {
		$this->themeEntity = 'Sandvine File Cloud';
		$this->themeName = 'Sandvine';
		$this->themeTitle = 'Sandvine File Cloud';
		$this->themeBaseUrl = 'https://cloud.sandvine.rocks';
		$this->themeDocBaseUrl = 'https://cloud.sandvine.rocks';
		$this->themeSyncClientUrl = 'https://cloud.sandvine.rocks';
		$this->themeSlogan = 'Sandvine Rocks';
		$this->themeMailHeaderColor = '#ffffff';
	}
	public function getBaseUrl() {
		return $this->themeBaseUrl;
	}

	public function getSyncClientUrl() {
		return $this->themeSyncClientUrl;
	}

	public function getDocBaseUrl() {
		return $this->themeDocBaseUrl;
	}

	public function getTitle() {
		return $this->themeTitle;
	}

	public function getName() {
		return $this->themeName;
	}

	public function getEntity() {
		return $this->themeEntity;
	}

	public function getSlogan() {
		return $this->themeSlogan;
	}

	public function getShortFooter() {
		$footer = '';
			'<br/>' . $this->getSlogan();

		return $footer;
	}

	public function getLongFooter() {
		$footer = '';

		return $footer;
	}

	public function buildDocLinkToKey($key) {
		return $this->getDocBaseUrl() . '/server/8.0/go.php?to=' . $key;
	}

	public function getMailHeaderColor() {
		return $this->themeMailHeaderColor;
	}

}
