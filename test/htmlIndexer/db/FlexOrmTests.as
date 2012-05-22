package htmlIndexer.db
{

	import flash.data.SQLStatement;
	import flash.events.SQLEvent;

	import htmlIndexer.mate.vos.LinkVO;
	import htmlIndexer.mate.vos.PageVO;

	import mx.collections.ArrayCollection;

	import nz.co.codec.flexorm.EntityManager;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.async.Async;

	public class FlexOrmTests
	{

		private var em:EntityManager = EntityManager.instance;

		[BeforeClass]
		public static function initDbConnection():void
		{
			EntityManager.instance.openSyncConnection('test');
		}

		[AfterClass]
		public static function releaseDbConnection():void
		{
			EntityManager.instance.sqlConnection.close();
		}

		[After(async)]
		public function after():void
		{
			const sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.sqlConnection = em.sqlConnection;

			sqlStatement.text = 'DELETE FROM links;';
			Async.proceedOnEvent(this, sqlStatement, SQLEvent.RESULT);
			sqlStatement.execute();

			sqlStatement.text = 'DELETE FROM pages;';
			Async.proceedOnEvent(this, sqlStatement, SQLEvent.RESULT);
			sqlStatement.execute();
		}

		[Test]
		public function testLinkCreation():void
		{
			const firstLink:LinkVO = new LinkVO('http://ya.ru', 'Яндекс');
			em.save(firstLink);

			assertEquals(1, em.findAll(LinkVO).length);

			const secondLink:LinkVO = new LinkVO('http://yarovoy.com', "Brains'trim");
			em.save(secondLink);

			assertEquals(2, em.findAll(LinkVO).length);
		}

		[Test]
		public function testLinkRemoving():void
		{
			const link:LinkVO = new LinkVO('http://ya.ru', 'Яндекс');
			em.save(link);

			assertEquals(1, em.findAll(LinkVO).length);

			em.remove(link);

			assertEquals(0, em.findAll(LinkVO).length);
		}

		[Test]
		public function testPageCreation():void
		{
			em.save(new PageVO('http://ya.ru'));

			assertEquals(1, em.findAll(PageVO).length);

			em.save(new PageVO('http://yarovoy.com'));

			assertEquals(2, em.findAll(PageVO).length);
		}

		[Test]
		public function testPageRemoving():void
		{
			const page:PageVO = new PageVO('http://ya.ru');
			em.save(page);

			assertEquals(1, em.findAll(PageVO).length);

			em.remove(page);

			assertEquals(0, em.findAll(PageVO).length);
		}

		[Test]
		public function testCascadeSaveAndUpdate():void
		{
			assertEquals(0, em.findAll(PageVO).length);
			assertEquals(0, em.findAll(LinkVO).length);

			const page:PageVO = new PageVO(
					'http://ya.ru',
					[
						new LinkVO('http://ya.ru', 'Яндекс'),
						new LinkVO('http://yarovoy.com', "Brains'trim")
					]
			);

			em.save(page);
			var pagesResult:ArrayCollection = em.findAll(PageVO);
			var linksResult:ArrayCollection = em.findAll(LinkVO);
			const page0:PageVO = pagesResult.getItemAt(0) as PageVO;
			const link0:LinkVO = linksResult.getItemAt(0) as LinkVO;

			assertEquals(1, pagesResult.length);
			assertEquals(2, linksResult.length);
			assertNotNull(link0.page);
			assertNotNull(link0.page.id);
			assertEquals(link0.page.id, page.id);

			page.links.addItem(new LinkVO('http://google.com', 'Google'));
			em.save(page);
			pagesResult = em.findAll(PageVO);
			linksResult = em.findAll(LinkVO);

			assertEquals(1, pagesResult.length);
			assertEquals(3, linksResult.length);
		}


		[Test]
		public function testCascadeRemoving():void
		{
			assertEquals(0, em.findAll(PageVO).length);
			assertEquals(0, em.findAll(LinkVO).length);

			const page:PageVO = new PageVO(
					'http://ya.ru',
					[
						new LinkVO('http://ya.ru', 'Яндекс'),
						new LinkVO('http://yarovoy.com', "Brains'trim")
					]
			);

			em.save(page);

			var pagesResult:ArrayCollection = em.findAll(PageVO);
			var linksResult:ArrayCollection = em.findAll(LinkVO);

			assertEquals(1, pagesResult.length);
			assertEquals(2, linksResult.length);

			em.remove(page);

			pagesResult = em.findAll(PageVO);
			linksResult = em.findAll(LinkVO);

			assertEquals(0, pagesResult.length);
			assertEquals(0, linksResult.length);
		}
	}
}