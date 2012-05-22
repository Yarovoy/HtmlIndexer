package htmlIndexer.db
{

	import flash.data.SQLStatement;

	import htmlIndexer.mate.vos.LinkVO;

	import mx.collections.ArrayCollection;

	import nz.co.codec.flexorm.EntityManager;

	import org.flexunit.asserts.assertEquals;

	public class FlexOrmTests
	{

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

		[After]
		public function after():void
		{
			const sqlStatement:SQLStatement = new SQLStatement();
			sqlStatement.text = 'DELETE FROM links; DELETE FROM pages;';
			sqlStatement.sqlConnection =  EntityManager.instance.sqlConnection;
			sqlStatement.execute();
		}

		[Test]
		public function testLinkCreating():void
		{
			const firstLink:LinkVO = new LinkVO('http://ya.ru', 'Яндекс');
			EntityManager.instance.save(firstLink);

			var result:ArrayCollection =  EntityManager.instance.findAll(LinkVO);
			assertEquals(1, result.length);

			const secondLink:LinkVO = new LinkVO('http://yarovoy.com', "Brains'trim");
			EntityManager.instance.save(secondLink);

			result =  EntityManager.instance.findAll(LinkVO);
			assertEquals(2, result.length);
		}

		[Test]
		public function testLinkRemoving():void
		{
			const link:LinkVO = new LinkVO('http://ya.ru', 'Яндекс');
			EntityManager.instance.save(link);

			assertEquals(1,  EntityManager.instance.findAll(LinkVO).length);

			EntityManager.instance.remove(link);

			assertEquals(0,  EntityManager.instance.findAll(LinkVO).length);
		}
	}
}